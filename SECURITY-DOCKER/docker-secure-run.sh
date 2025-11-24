#!/bin/bash

###############################################################################
# Docker Secure Run Helper Script
#
# This script provides a wrapper to run Docker containers with security
# best practices automatically applied.
#
# Usage: ./docker-secure-run.sh [OPTIONS] IMAGE [COMMAND] [ARG...]
#
# This script automatically applies:
#   - Non-root user (unless --allow-root)
#   - Dropped capabilities (--cap-drop=ALL)
#   - Resource limits
#   - Read-only root filesystem (unless --writable)
#   - Security options (AppArmor, Seccomp)
#   - No new privileges
#   - Network isolation
#
###############################################################################

set -euo pipefail

# Default security settings
DROP_CAPS=true
READONLY_FS=true
RESOURCE_LIMITS=true
SECURITY_OPTS=true
ALLOW_ROOT=false
NETWORK_ISOLATED=true

# Default resource limits
MEMORY_LIMIT="512m"
CPU_LIMIT="1.0"
PIDS_LIMIT="100"

# Additional docker run arguments
EXTRA_ARGS=()
IMAGE=""
CMD_ARGS=()

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

###############################################################################
# Helper Functions
###############################################################################

show_help() {
    cat << EOF
Docker Secure Run - Run containers with security best practices

Usage: ./docker-secure-run.sh [OPTIONS] IMAGE [COMMAND] [ARG...]

Security Options (enabled by default):
  --allow-root              Allow running as root (not recommended)
  --writable                Allow writable root filesystem
  --no-limits               Disable resource limits
  --allow-new-privs         Allow new privileges
  --host-network            Use host network (not recommended)

Resource Limits (can be overridden):
  --memory <size>           Memory limit (default: 512m)
  --cpus <number>           CPU limit (default: 1.0)
  --pids-limit <number>     PID limit (default: 100)

Additional Capabilities:
  --cap-add <cap>           Add specific capability (use carefully)

Standard Docker Options:
  -d, --detach              Run container in background
  -p, --publish             Publish container port
  -v, --volume              Mount volume
  -e, --env                 Set environment variable
  --name                    Container name
  --rm                      Remove container on exit

Examples:
  # Run nginx with security defaults
  ./docker-secure-run.sh nginx:1.25

  # Run with custom memory and expose port
  ./docker-secure-run.sh --memory 1g -p 8080:80 nginx:1.25

  # Run with writable filesystem and specific user
  ./docker-secure-run.sh --writable -e USER=appuser myapp:latest

  # Run with additional capability
  ./docker-secure-run.sh --cap-add NET_BIND_SERVICE myapp:latest

  # Audit a running container
  ./docker-security-audit.sh --container my-container

EOF
}

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

###############################################################################
# Parse Arguments
###############################################################################

parse_args() {
    local parsing_image=false

    while [[ $# -gt 0 ]]; do
        case $1 in
            --help|-h)
                show_help
                exit 0
                ;;
            --allow-root)
                ALLOW_ROOT=true
                shift
                ;;
            --writable)
                READONLY_FS=false
                shift
                ;;
            --no-limits)
                RESOURCE_LIMITS=false
                shift
                ;;
            --allow-new-privs)
                SECURITY_OPTS=false
                shift
                ;;
            --host-network)
                NETWORK_ISOLATED=false
                print_warn "Host network mode reduces isolation"
                shift
                ;;
            --memory)
                MEMORY_LIMIT="$2"
                shift 2
                ;;
            --cpus)
                CPU_LIMIT="$2"
                shift 2
                ;;
            --pids-limit)
                PIDS_LIMIT="$2"
                shift 2
                ;;
            --cap-add)
                EXTRA_ARGS+=("--cap-add=$2")
                print_warn "Adding capability: $2"
                shift 2
                ;;
            -d|--detach)
                EXTRA_ARGS+=("$1")
                shift
                ;;
            --rm)
                EXTRA_ARGS+=("$1")
                shift
                ;;
            --name)
                EXTRA_ARGS+=("$1" "$2")
                shift 2
                ;;
            -p|--publish)
                EXTRA_ARGS+=("$1" "$2")
                shift 2
                ;;
            -v|--volume)
                # Check for sensitive mounts
                if [[ "$2" =~ ^/:|^/etc:|^/var/run/docker.sock ]]; then
                    print_error "Refusing to mount sensitive host path: $2"
                    print_error "This violates security best practices"
                    exit 1
                fi
                EXTRA_ARGS+=("$1" "$2")
                shift 2
                ;;
            -e|--env)
                EXTRA_ARGS+=("$1" "$2")
                shift 2
                ;;
            --*)
                print_error "Unknown option: $1"
                show_help
                exit 1
                ;;
            *)
                if [ -z "$IMAGE" ]; then
                    # Check if image uses :latest tag
                    if [[ "$1" == *":latest" ]]; then
                        print_warn "Using :latest tag is not recommended for production"
                    elif [[ "$1" != *":"* ]]; then
                        print_warn "No tag specified, will use :latest by default"
                    fi
                    IMAGE="$1"
                    parsing_image=true
                else
                    CMD_ARGS+=("$1")
                fi
                shift
                ;;
        esac
    done

    if [ -z "$IMAGE" ]; then
        print_error "No image specified"
        show_help
        exit 1
    fi
}

###############################################################################
# Build Docker Run Command
###############################################################################

build_secure_command() {
    local cmd=("docker" "run")

    # Drop all capabilities by default
    if [ "$DROP_CAPS" = true ]; then
        cmd+=("--cap-drop=ALL")
        print_info "Dropping all capabilities"
    fi

    # Read-only root filesystem
    if [ "$READONLY_FS" = true ]; then
        cmd+=("--read-only")
        cmd+=("--tmpfs" "/tmp:rw,noexec,nosuid,size=64m")
        cmd+=("--tmpfs" "/var/tmp:rw,noexec,nosuid,size=64m")
        print_info "Enabling read-only root filesystem"
    fi

    # Resource limits
    if [ "$RESOURCE_LIMITS" = true ]; then
        cmd+=("--memory=$MEMORY_LIMIT")
        cmd+=("--memory-swap=$MEMORY_LIMIT")
        cmd+=("--cpus=$CPU_LIMIT")
        cmd+=("--pids-limit=$PIDS_LIMIT")
        print_info "Applying resource limits: memory=$MEMORY_LIMIT, cpus=$CPU_LIMIT, pids=$PIDS_LIMIT"
    fi

    # Security options
    if [ "$SECURITY_OPTS" = true ]; then
        cmd+=("--security-opt=no-new-privileges:true")
        cmd+=("--security-opt=apparmor=docker-default")
        print_info "Enabling security options: no-new-privileges, apparmor"
    fi

    # Network isolation
    if [ "$NETWORK_ISOLATED" = true ]; then
        # Create isolated network if it doesn't exist
        if ! docker network inspect secure-isolated &>/dev/null; then
            print_info "Creating isolated network: secure-isolated"
            docker network create --driver bridge secure-isolated >/dev/null 2>&1 || true
        fi
        cmd+=("--network=secure-isolated")
    else
        cmd+=("--network=host")
    fi

    # Add extra arguments
    cmd+=("${EXTRA_ARGS[@]}")

    # Add image
    cmd+=("$IMAGE")

    # Add command arguments
    if [ ${#CMD_ARGS[@]} -gt 0 ]; then
        cmd+=("${CMD_ARGS[@]}")
    fi

    echo "${cmd[@]}"
}

###############################################################################
# Verification Functions
###############################################################################

check_image_exists() {
    print_info "Checking if image exists: $IMAGE"
    if ! docker image inspect "$IMAGE" &>/dev/null; then
        print_info "Image not found locally, will pull: $IMAGE"
    fi
}

get_image_user() {
    local user=$(docker image inspect "$IMAGE" --format='{{.Config.User}}' 2>/dev/null || echo "")
    echo "$user"
}

###############################################################################
# Main Execution
###############################################################################

main() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}Docker Secure Run${NC}"
    echo -e "${BLUE}================================${NC}"
    echo ""

    # Parse arguments
    parse_args "$@"

    # Check if Docker is available
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed or not in PATH"
        exit 1
    fi

    if ! docker info &> /dev/null; then
        print_error "Cannot connect to Docker daemon"
        exit 1
    fi

    # Check image
    check_image_exists

    # Check if image runs as root
    local image_user=$(get_image_user)
    if [ -z "$image_user" ] || [ "$image_user" = "root" ] || [ "$image_user" = "0" ]; then
        if [ "$ALLOW_ROOT" = false ]; then
            print_error "Image runs as root user"
            print_error "This violates security best practices"
            print_error "Options:"
            print_error "  1. Rebuild image with non-root USER directive"
            print_error "  2. Use --allow-root flag (not recommended)"
            exit 1
        else
            print_warn "Running as root (--allow-root specified)"
        fi
    else
        print_info "Image runs as user: $image_user"
    fi

    # Build and display command
    local cmd=$(build_secure_command)

    echo ""
    echo -e "${GREEN}Executing secure container:${NC}"
    echo -e "${BLUE}$cmd${NC}"
    echo ""

    # Execute
    eval "$cmd"
}

# Run main function with all arguments
main "$@"
