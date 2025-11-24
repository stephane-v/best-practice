# Docker Security Tools

This directory contains security tools for auditing and running Docker containers with security best practices.

## Tools

### 1. docker-security-audit.sh

Comprehensive security audit script that checks running containers and Docker daemon configuration against security best practices.

**Features:**
- Audits container security configurations
- Checks for common vulnerabilities
- Validates Docker daemon settings
- Provides detailed remediation guidance
- Calculates security score

**Usage:**
```bash
# Audit all running containers
./docker-security-audit.sh

# Audit specific container
./docker-security-audit.sh --container my-container

# Show daemon configuration fixes
./docker-security-audit.sh --fix-daemon
```

### 2. docker-secure-run.sh

Helper script to run containers with security best practices automatically applied.

**Features:**
- Runs containers as non-root by default
- Drops all capabilities
- Applies resource limits
- Enables read-only root filesystem
- Configures security options
- Validates against dangerous configurations

**Usage:**
```bash
# Run with security defaults
./docker-secure-run.sh nginx:1.25

# Run with custom resources
./docker-secure-run.sh --memory 1g --cpus 2 nginx:1.25

# Run with port mapping
./docker-secure-run.sh -p 8080:80 nginx:1.25

# Run detached with name
./docker-secure-run.sh -d --name web-server nginx:1.25
```

## Quick Start

1. Make scripts executable (if not already):
```bash
chmod +x docker-security-audit.sh docker-secure-run.sh
```

2. Run audit to check current security posture:
```bash
./docker-security-audit.sh
```

3. Use secure-run for new containers:
```bash
./docker-secure-run.sh your-image:tag
```

## Security Checklist Coverage

Both scripts address the following security controls:

- ✅ Containers run as non-root users
- ✅ Read-only root filesystem enabled where possible
- ✅ Unnecessary capabilities dropped
- ✅ Resource limits configured
- ✅ No privileged containers in production
- ✅ Docker socket not mounted in containers
- ✅ Images scanned for vulnerabilities
- ✅ Using specific image tags (not :latest)
- ✅ Secrets not stored in images
- ✅ Security profiles (AppArmor/Seccomp) enabled
- ✅ User namespace remapping enabled
- ✅ Docker daemon properly secured
- ✅ Network segmentation implemented
- ✅ Runtime security monitoring active
- ✅ Regular security updates and patching
- ✅ Audit logging enabled

## Requirements

- Docker installed and running
- Bash 4.0 or higher
- Root/sudo access for daemon checks
- Optional: Trivy for vulnerability scanning

## Installation

```bash
# Clone or download scripts
git clone <repository>
cd SECURITY-DOCKER

# Make executable
chmod +x *.sh

# Optional: Install Trivy for vulnerability scanning
# https://github.com/aquasecurity/trivy
```

## Integration

### CI/CD Pipeline

Add audit to your CI/CD:

```yaml
# Example GitLab CI
security-audit:
  script:
    - ./SECURITY-DOCKER/docker-security-audit.sh
  allow_failure: false
```

### Pre-deployment Checks

Use as pre-deployment gate:

```bash
#!/bin/bash
if ./docker-security-audit.sh; then
    echo "Security audit passed"
    deploy_application
else
    echo "Security audit failed - deployment blocked"
    exit 1
fi
```

### Container Wrapper

Replace `docker run` with secure wrapper:

```bash
# Instead of:
# docker run -d nginx

# Use:
./docker-secure-run.sh -d nginx:1.25
```

## Troubleshooting

### Audit Script Issues

**Problem:** Permission denied
```bash
# Solution: Run with sudo
sudo ./docker-security-audit.sh
```

**Problem:** Cannot connect to Docker daemon
```bash
# Solution: Add user to docker group
sudo usermod -aG docker $USER
# Then log out and back in
```

### Secure Run Issues

**Problem:** Image runs as root
```bash
# Solution 1: Rebuild image with USER directive
# Solution 2: Use --allow-root (not recommended)
./docker-secure-run.sh --allow-root image:tag
```

**Problem:** Application needs write access
```bash
# Solution: Use --writable flag and mount specific volumes
./docker-secure-run.sh --writable -v /app/data:/data image:tag
```

**Problem:** Need specific capability
```bash
# Solution: Add specific capability
./docker-secure-run.sh --cap-add NET_BIND_SERVICE image:tag
```

## Contributing

Improvements and contributions welcome! Please ensure:
- Scripts remain POSIX-compliant where possible
- Security checks are well-documented
- Changes don't weaken security posture

## License

See parent repository LICENSE file.
