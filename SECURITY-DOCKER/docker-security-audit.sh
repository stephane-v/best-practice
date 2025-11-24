#!/bin/bash

###############################################################################
# Docker Security Audit Script
#
# This script audits running Docker containers and daemon configuration
# against security best practices.
#
# Usage: ./docker-security-audit.sh [OPTIONS]
#
# Options:
#   --container <name|id>   Audit specific container
#   --all                   Audit all running containers (default)
#   --json                  Output results in JSON format
#   --fix-daemon            Show commands to fix daemon configuration
#   --help                  Show this help message
#
###############################################################################

set -euo pipefail

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
PASS_COUNT=0
FAIL_COUNT=0
WARN_COUNT=0
INFO_COUNT=0

# Output mode
OUTPUT_JSON=false
SPECIFIC_CONTAINER=""
FIX_DAEMON=false

###############################################################################
# Helper Functions
###############################################################################

print_header() {
    echo -e "${BLUE}============================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}============================================${NC}"
}

print_pass() {
    echo -e "${GREEN}[PASS]${NC} $1"
    ((PASS_COUNT++))
}

print_fail() {
    echo -e "${RED}[FAIL]${NC} $1"
    ((FAIL_COUNT++))
}

print_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
    ((WARN_COUNT++))
}

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
    ((INFO_COUNT++))
}

check_docker() {
    if ! command -v docker &> /dev/null; then
        echo -e "${RED}Error: Docker is not installed or not in PATH${NC}"
        exit 1
    fi

    if ! docker info &> /dev/null; then
        echo -e "${RED}Error: Cannot connect to Docker daemon. Are you running with sufficient privileges?${NC}"
        exit 1
    fi
}

###############################################################################
# Container Security Checks
###############################################################################

check_container_user() {
    local container=$1
    local user=$(docker inspect --format='{{.Config.User}}' "$container" 2>/dev/null || echo "")

    if [ -z "$user" ] || [ "$user" = "root" ] || [ "$user" = "0" ]; then
        print_fail "Container $container is running as root"
        echo "         Fix: Add 'USER <non-root-user>' to Dockerfile or use --user flag"
        return 1
    else
        print_pass "Container $container is running as user: $user"
        return 0
    fi
}

check_privileged_mode() {
    local container=$1
    local privileged=$(docker inspect --format='{{.HostConfig.Privileged}}' "$container")

    if [ "$privileged" = "true" ]; then
        print_fail "Container $container is running in PRIVILEGED mode"
        echo "         Fix: Remove --privileged flag"
        return 1
    else
        print_pass "Container $container is not privileged"
        return 0
    fi
}

check_capabilities() {
    local container=$1
    local cap_add=$(docker inspect --format='{{.HostConfig.CapAdd}}' "$container")
    local cap_drop=$(docker inspect --format='{{.HostConfig.CapDrop}}' "$container")

    if [ "$cap_drop" = "[]" ] || [ "$cap_drop" = "<no value>" ]; then
        print_warn "Container $container has not dropped any capabilities"
        echo "         Recommendation: Use --cap-drop=ALL and add only required capabilities"
        return 1
    else
        print_pass "Container $container has dropped capabilities: $cap_drop"
    fi

    if [ "$cap_add" != "[]" ] && [ "$cap_add" != "<no value>" ]; then
        print_info "Container $container has added capabilities: $cap_add"
    fi

    return 0
}

check_readonly_rootfs() {
    local container=$1
    local readonly=$(docker inspect --format='{{.HostConfig.ReadonlyRootfs}}' "$container")

    if [ "$readonly" = "true" ]; then
        print_pass "Container $container has read-only root filesystem"
        return 0
    else
        print_warn "Container $container does not have read-only root filesystem"
        echo "         Recommendation: Use --read-only flag with --tmpfs for writable directories"
        return 1
    fi
}

check_resource_limits() {
    local container=$1
    local memory=$(docker inspect --format='{{.HostConfig.Memory}}' "$container")
    local cpu_quota=$(docker inspect --format='{{.HostConfig.CpuQuota}}' "$container")
    local pids_limit=$(docker inspect --format='{{.HostConfig.PidsLimit}}' "$container")

    local limits_set=0

    if [ "$memory" != "0" ]; then
        print_pass "Container $container has memory limit: $(( memory / 1024 / 1024 ))MB"
        ((limits_set++))
    else
        print_warn "Container $container has no memory limit"
    fi

    if [ "$cpu_quota" != "0" ] && [ "$cpu_quota" != "-1" ]; then
        print_pass "Container $container has CPU quota: $cpu_quota"
        ((limits_set++))
    else
        print_warn "Container $container has no CPU limit"
    fi

    if [ "$pids_limit" != "0" ] && [ "$pids_limit" != "-1" ]; then
        print_pass "Container $container has PID limit: $pids_limit"
        ((limits_set++))
    else
        print_warn "Container $container has no PID limit"
    fi

    if [ $limits_set -eq 0 ]; then
        echo "         Recommendation: Set --memory, --cpus, and --pids-limit"
        return 1
    fi

    return 0
}

check_docker_socket_mount() {
    local container=$1
    local mounts=$(docker inspect --format='{{range .Mounts}}{{.Source}}:{{.Destination}}{{"\n"}}{{end}}' "$container")

    if echo "$mounts" | grep -q "docker.sock"; then
        print_fail "Container $container has Docker socket mounted"
        echo "         Fix: Remove -v /var/run/docker.sock mount"
        return 1
    else
        print_pass "Container $container does not mount Docker socket"
        return 0
    fi
}

check_sensitive_host_mounts() {
    local container=$1
    local mounts=$(docker inspect --format='{{range .Mounts}}{{.Source}}{{"\n"}}{{end}}' "$container")

    local sensitive_paths=("/" "/etc" "/var" "/boot" "/dev" "/proc" "/sys")
    local found_sensitive=0

    for path in "${sensitive_paths[@]}"; do
        if echo "$mounts" | grep -q "^${path}$"; then
            print_fail "Container $container mounts sensitive host path: $path"
            ((found_sensitive++))
        fi
    done

    if [ $found_sensitive -eq 0 ]; then
        print_pass "Container $container has no sensitive host mounts"
        return 0
    else
        echo "         Fix: Remove sensitive host path mounts"
        return 1
    fi
}

check_network_mode() {
    local container=$1
    local network_mode=$(docker inspect --format='{{.HostConfig.NetworkMode}}' "$container")

    if [ "$network_mode" = "host" ]; then
        print_fail "Container $container uses host network mode"
        echo "         Fix: Remove --net=host flag"
        return 1
    else
        print_pass "Container $container uses isolated network: $network_mode"
        return 0
    fi
}

check_security_options() {
    local container=$1
    local security_opt=$(docker inspect --format='{{.HostConfig.SecurityOpt}}' "$container")

    if [ "$security_opt" = "[]" ] || [ "$security_opt" = "<no value>" ]; then
        print_warn "Container $container has no security options (AppArmor/Seccomp)"
        echo "         Recommendation: Add --security-opt apparmor=docker-default"
        return 1
    else
        # Check for unconfined
        if echo "$security_opt" | grep -q "unconfined"; then
            print_fail "Container $container has security features disabled (unconfined)"
            return 1
        else
            print_pass "Container $container has security options: $security_opt"
            return 0
        fi
    fi
}

check_no_new_privileges() {
    local container=$1
    local no_new_privs=$(docker inspect --format='{{.HostConfig.SecurityOpt}}' "$container" | grep -o "no-new-privileges:true" || echo "")

    if [ -n "$no_new_privs" ]; then
        print_pass "Container $container has no-new-privileges enabled"
        return 0
    else
        print_warn "Container $container does not have no-new-privileges"
        echo "         Recommendation: Add --security-opt=no-new-privileges:true"
        return 1
    fi
}

check_image_tag() {
    local container=$1
    local image=$(docker inspect --format='{{.Config.Image}}' "$container")

    if echo "$image" | grep -q ":latest$"; then
        print_fail "Container $container uses :latest tag: $image"
        echo "         Fix: Use specific version tags"
        return 1
    elif echo "$image" | grep -q ":"; then
        print_pass "Container $container uses specific tag: $image"
        return 0
    else
        print_warn "Container $container has no explicit tag: $image"
        return 1
    fi
}

###############################################################################
# Image Security Checks
###############################################################################

check_image_vulnerabilities() {
    local container=$1
    local image=$(docker inspect --format='{{.Config.Image}}' "$container")

    print_info "Checking image vulnerabilities for: $image"

    # Check if trivy is installed
    if command -v trivy &> /dev/null; then
        local critical=$(trivy image --severity CRITICAL --quiet "$image" 2>/dev/null | grep -c "CRITICAL" || echo "0")
        local high=$(trivy image --severity HIGH --quiet "$image" 2>/dev/null | grep -c "HIGH" || echo "0")

        if [ "$critical" != "0" ] || [ "$high" != "0" ]; then
            print_fail "Image $image has vulnerabilities: CRITICAL=$critical, HIGH=$high"
            echo "         Fix: Update base image and rebuild"
            return 1
        else
            print_pass "Image $image has no critical/high vulnerabilities"
            return 0
        fi
    else
        print_warn "Trivy not installed - skipping vulnerability scan"
        echo "         Install: https://github.com/aquasecurity/trivy"
        return 1
    fi
}

###############################################################################
# Daemon Security Checks
###############################################################################

check_daemon_config() {
    print_header "Docker Daemon Configuration"

    local daemon_config="/etc/docker/daemon.json"

    if [ ! -f "$daemon_config" ]; then
        print_warn "Docker daemon.json not found at $daemon_config"
        echo "         Recommendation: Create daemon.json with security settings"
        return 1
    fi

    print_pass "Docker daemon.json exists"

    # Check for user namespace remapping
    if grep -q '"userns-remap"' "$daemon_config" 2>/dev/null; then
        print_pass "User namespace remapping is configured"
    else
        print_warn "User namespace remapping is not configured"
        echo "         Recommendation: Add \"userns-remap\": \"default\""
    fi

    # Check for icc (inter-container communication)
    if grep -q '"icc".*false' "$daemon_config" 2>/dev/null; then
        print_pass "Inter-container communication is disabled"
    else
        print_warn "Inter-container communication is not explicitly disabled"
        echo "         Recommendation: Add \"icc\": false"
    fi

    # Check for live-restore
    if grep -q '"live-restore".*true' "$daemon_config" 2>/dev/null; then
        print_pass "Live restore is enabled"
    else
        print_info "Live restore is not enabled"
    fi
}

check_docker_socket_permissions() {
    local socket="/var/run/docker.sock"

    if [ -S "$socket" ]; then
        local perms=$(stat -c %a "$socket" 2>/dev/null || stat -f %Lp "$socket" 2>/dev/null)
        local owner=$(stat -c %U "$socket" 2>/dev/null || stat -f %Su "$socket" 2>/dev/null)

        if [ "$perms" = "660" ] || [ "$perms" = "600" ]; then
            print_pass "Docker socket has secure permissions: $perms"
        else
            print_warn "Docker socket permissions are not restrictive: $perms"
            echo "         Recommendation: chmod 660 $socket"
        fi

        if [ "$owner" = "root" ]; then
            print_pass "Docker socket is owned by root"
        else
            print_warn "Docker socket owner is: $owner"
        fi
    fi
}

check_docker_daemon_exposure() {
    local exposed=$(docker info 2>/dev/null | grep -i "TCP" || echo "")

    if [ -z "$exposed" ]; then
        print_pass "Docker daemon is not exposed over TCP"
    else
        # Check if TLS is configured
        if docker info 2>/dev/null | grep -q "TLS"; then
            print_pass "Docker daemon is exposed with TLS"
        else
            print_fail "Docker daemon is exposed over TCP without TLS"
            echo "         Fix: Configure TLS or disable TCP exposure"
        fi
    fi
}

###############################################################################
# Audit All Containers
###############################################################################

audit_container() {
    local container=$1
    local container_name=$(docker inspect --format='{{.Name}}' "$container" | sed 's/\///')

    print_header "Auditing Container: $container_name ($container)"

    check_container_user "$container"
    check_privileged_mode "$container"
    check_capabilities "$container"
    check_readonly_rootfs "$container"
    check_resource_limits "$container"
    check_docker_socket_mount "$container"
    check_sensitive_host_mounts "$container"
    check_network_mode "$container"
    check_security_options "$container"
    check_no_new_privileges "$container"
    check_image_tag "$container"
    check_image_vulnerabilities "$container"

    echo ""
}

###############################################################################
# Main Execution
###############################################################################

show_help() {
    cat << EOF
Docker Security Audit Script

Usage: ./docker-security-audit.sh [OPTIONS]

Options:
  --container <name|id>   Audit specific container
  --all                   Audit all running containers (default)
  --json                  Output results in JSON format
  --fix-daemon            Show commands to fix daemon configuration
  --help                  Show this help message

Examples:
  ./docker-security-audit.sh
  ./docker-security-audit.sh --container my-container
  ./docker-security-audit.sh --fix-daemon

EOF
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --container)
            SPECIFIC_CONTAINER="$2"
            shift 2
            ;;
        --all)
            SPECIFIC_CONTAINER=""
            shift
            ;;
        --json)
            OUTPUT_JSON=true
            shift
            ;;
        --fix-daemon)
            FIX_DAEMON=true
            shift
            ;;
        --help)
            show_help
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Check Docker availability
check_docker

# Print banner
echo ""
print_header "Docker Security Audit"
echo -e "Date: $(date)"
echo -e "Docker Version: $(docker version --format '{{.Server.Version}}')"
echo ""

# Check daemon configuration
check_daemon_config
check_docker_socket_permissions
check_docker_daemon_exposure
echo ""

# Audit containers
if [ -n "$SPECIFIC_CONTAINER" ]; then
    if docker ps -q -f name="$SPECIFIC_CONTAINER" | grep -q .; then
        audit_container "$SPECIFIC_CONTAINER"
    else
        echo -e "${RED}Error: Container '$SPECIFIC_CONTAINER' not found or not running${NC}"
        exit 1
    fi
else
    # Audit all running containers
    containers=$(docker ps -q)

    if [ -z "$containers" ]; then
        print_warn "No running containers found"
    else
        for container in $containers; do
            audit_container "$container"
        done
    fi
fi

# Print summary
print_header "Audit Summary"
echo -e "${GREEN}Passed:  $PASS_COUNT${NC}"
echo -e "${RED}Failed:  $FAIL_COUNT${NC}"
echo -e "${YELLOW}Warnings: $WARN_COUNT${NC}"
echo -e "${BLUE}Info:    $INFO_COUNT${NC}"
echo ""

# Calculate score
total=$((PASS_COUNT + FAIL_COUNT + WARN_COUNT))
if [ $total -gt 0 ]; then
    score=$((PASS_COUNT * 100 / total))
    echo -e "Security Score: ${BLUE}${score}%${NC}"

    if [ $score -ge 80 ]; then
        echo -e "${GREEN}Status: GOOD${NC}"
    elif [ $score -ge 60 ]; then
        echo -e "${YELLOW}Status: NEEDS IMPROVEMENT${NC}"
    else
        echo -e "${RED}Status: CRITICAL - IMMEDIATE ACTION REQUIRED${NC}"
    fi
fi

echo ""

# Show daemon fix suggestions if requested
if [ "$FIX_DAEMON" = true ]; then
    print_header "Docker Daemon Configuration Fixes"
    cat << 'EOF'
Create or update /etc/docker/daemon.json with secure settings:

{
  "icc": false,
  "userns-remap": "default",
  "no-new-privileges": true,
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  },
  "live-restore": true,
  "userland-proxy": false
}

After updating, restart Docker daemon:
sudo systemctl restart docker

Enable user namespace remapping:
echo "dockremap:165536:65536" | sudo tee -a /etc/subuid
echo "dockremap:165536:65536" | sudo tee -a /etc/subgid

EOF
fi

# Exit with appropriate code
if [ $FAIL_COUNT -gt 0 ]; then
    exit 1
else
    exit 0
fi
