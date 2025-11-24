# Cybersecurity Risk Assessment Template

## Organization Information
- **Organization Name**: ___________________________
- **Assessment Date**: ___________________________
- **Assessment Conducted By**: ___________________________
- **Assessment Period**: ___________________________
- **Next Assessment Due**: ___________________________

---

## Risk Assessment Methodology

**Risk Scoring:**
```
Risk Score = Likelihood × Impact

Likelihood: 1 (Rare) to 5 (Very Likely)
Impact: 1 (Negligible) to 5 (Catastrophic)
Risk Score: 1-25
```

**Risk Levels:**
- **25-20**: CRITICAL - Immediate action required
- **19-12**: HIGH - Action required within 30 days
- **11-6**: MEDIUM - Action required within 90 days
- **5-1**: LOW - Monitor and review

---

## Risk Register

### Risk 1: [Risk Name]

**Risk Description**: _________________________________________________________________

**Asset(s) Affected**: ______________________________________________________________

**Threat Actor**: ☐ External Attacker ☐ Insider ☐ Natural Disaster ☐ Other: ________

**Vulnerability**: __________________________________________________________________

**Current Controls**: _______________________________________________________________

**Likelihood (1-5)**: ___ (1=Rare, 2=Unlikely, 3=Possible, 4=Likely, 5=Very Likely)

**Impact (1-5)**: ___ (1=Negligible, 2=Minor, 3=Moderate, 4=Major, 5=Catastrophic)

**Risk Score**: ___ (Likelihood × Impact)

**Risk Level**: ☐ CRITICAL ☐ HIGH ☐ MEDIUM ☐ LOW

**Risk Treatment**:
- ☐ Mitigate (implement controls)
- ☐ Accept (document acceptance)
- ☐ Transfer (insurance)
- ☐ Avoid (eliminate activity)

**Recommended Actions**:
1. ____________________________________________________________
2. ____________________________________________________________
3. ____________________________________________________________

**Owner**: _________________________ **Target Date**: ______________

**Residual Risk (after mitigation)**: ___ (recalculate after controls implemented)

---

## Pre-Filled Common Cyber Risks

### RISK #1: Ransomware Attack

**Risk Description**: Ransomware encrypts critical systems and data, demanding payment for decryption

**Asset(s) Affected**: All servers, workstations, file shares, databases

**Threat Actor**: ☑ External Attacker (Ransomware groups)

**Vulnerability**:
- Unpatched systems
- No MFA on remote access
- Insufficient backup protection
- Phishing susceptibility

**Current Controls**:
☐ Antivirus/EDR deployed
☐ MFA on VPN access
☐ Regular patching
☐ Immutable backups
☐ Email filtering
☐ User training

**Likelihood**: ____ (Rate based on controls above)
- If no MFA or immutable backups: **5 (Very Likely)**
- If basic controls but gaps: **3-4**
- If comprehensive controls: **2**

**Impact**: ____ (Rate based on business criticality)
- Critical business systems, no backup: **5 (Catastrophic)**
- Critical systems, backups available: **3-4**
- Non-critical systems: **2-3**

**Risk Score**: ____ × ____ = ____

**Recommended Actions**:
1. Implement MFA on all remote access (VPN, RDP, cloud services)
2. Deploy immutable/air-gapped backups, test monthly
3. Deploy EDR with 24/7 monitoring
4. Conduct phishing simulations quarterly
5. Patch critical vulnerabilities within 14 days
6. Network segmentation to limit lateral movement

**Owner**: CISO **Target Date**: __________

---

### RISK #2: Data Breach / Unauthorized Access

**Risk Description**: Unauthorized access to sensitive data (customer PII, PHI, financial data, IP)

**Asset(s) Affected**: _______________________________________________________________
(e.g., Customer database, file servers, cloud storage, email)

**Threat Actor**: ☐ External Attacker ☐ Insider ☐ Compromised Credentials

**Vulnerability**:
- Weak access controls
- No data encryption
- Excessive user permissions
- No data loss prevention (DLP)

**Current Controls**:
☐ Data classified and inventoried
☐ Encryption at rest and in transit
☐ Access controls (least privilege)
☐ Regular access reviews
☐ DLP deployed
☐ Monitoring and alerting

**Likelihood**: ____
- If sensitive data unencrypted, weak access controls: **4-5**
- If basic controls: **3**
- If comprehensive controls: **2**

**Impact**: ____ (Consider # of records, data sensitivity, regulatory requirements)
- Large-scale PII/PHI breach (>10K records): **5**
- Moderate breach (1K-10K records): **4**
- Small breach (<1K records): **3**
- Non-sensitive data: **2**

**Risk Score**: ____ × ____ = ____

**Recommended Actions**:
1. Encrypt all sensitive data (at rest and in transit)
2. Implement least privilege access controls
3. Deploy DLP on endpoints, email, and cloud
4. Conduct quarterly access reviews
5. Enable MFA on all accounts with data access
6. Implement user behavior analytics (UBA)
7. Regular vulnerability scanning and penetration testing

**Owner**: _____________ **Target Date**: __________

---

### RISK #3: Phishing / Business Email Compromise (BEC)

**Risk Description**: Employees fall for phishing emails, leading to credential compromise or fraudulent wire transfers

**Asset(s) Affected**: Email system, employee accounts, financial systems

**Threat Actor**: ☑ External Attacker (Phishing campaigns, BEC scammers)

**Vulnerability**:
- Insufficient email security
- Lack of user awareness
- Weak financial controls
- No email authentication (DMARC)

**Current Controls**:
☐ Advanced email filtering (sandbox attachments/links)
☐ Security awareness training
☐ Phishing simulations
☐ MFA on email
☐ DMARC, DKIM, SPF configured
☐ Financial controls (dual approval for wire transfers)

**Likelihood**: ____
- If no training, basic email security: **4-5**
- If training but weak email security: **3**
- If comprehensive controls: **2**

**Impact**: ____
- BEC leading to major financial loss: **4-5**
- Credential compromise leading to data breach: **4**
- Contained phishing incident: **2-3**

**Risk Score**: ____ × ____ = ____

**Recommended Actions**:
1. Deploy advanced email threat protection (sandbox/detonate attachments)
2. Mandatory security awareness training (annual minimum)
3. Quarterly phishing simulations, track click rates
4. Implement MFA on email accounts
5. Configure DMARC, DKIM, SPF (email authentication)
6. Financial controls: Dual approval for wires >$X, out-of-band verification
7. Easy user reporting mechanism for suspicious emails

**Owner**: _____________ **Target Date**: __________

---

### RISK #4: Insider Threat

**Risk Description**: Malicious or negligent insider misuses access to steal data, cause disruption, or commit fraud

**Asset(s) Affected**: All systems and data (insiders have legitimate access)

**Threat Actor**: ☑ Insider (Malicious, negligent, or compromised)

**Vulnerability**:
- Excessive user privileges
- Insufficient monitoring
- No data exfiltration controls
- Weak offboarding process

**Current Controls**:
☐ Least privilege access
☐ User activity monitoring
☐ DLP deployed
☐ Insider threat program
☐ Background checks
☐ Access reviews
☐ Offboarding process

**Likelihood**: ____
- If privileged users not monitored: **3-4**
- If basic controls: **2-3**
- If comprehensive insider threat program: **1-2**

**Impact**: ____
- Theft of IP or large-scale customer data: **5**
- Moderate data theft: **3-4**
- Policy violation, no data loss: **2**

**Risk Score**: ____ × ____ = ____

**Recommended Actions**:
1. Implement least privilege access model
2. Deploy user behavior analytics (UBA)
3. Enable DLP on endpoints, email, USB devices
4. Establish insider threat program (Security, HR, Legal)
5. Monitor high-risk users (privileged, departing, disgruntled)
6. Conduct quarterly access reviews
7. Secure offboarding process (immediate access revocation)

**Owner**: _____________ **Target Date**: __________

---

### RISK #5: Unpatched Vulnerabilities

**Risk Description**: Unpatched systems exploited by attackers to gain access or cause disruption

**Asset(s) Affected**: All systems (servers, workstations, network devices, applications)

**Threat Actor**: ☑ External Attacker (Exploit kits, targeted attacks)

**Vulnerability**:
- Lack of patch management process
- End-of-life systems
- Slow patch deployment
- Unknown system inventory

**Current Controls**:
☐ Vulnerability scanning
☐ Patch management process
☐ Automated patching
☐ Asset inventory
☐ Virtual patching (WAF, IPS)

**Likelihood**: ____
- If patches delayed months, EOL systems: **5**
- If critical patches within 30 days: **3**
- If critical patches within 14 days: **2**

**Impact**: ____
- Internet-facing critical systems: **5**
- Internal critical systems: **4**
- Non-critical systems: **2-3**

**Risk Score**: ____ × ____ = ____

**Recommended Actions**:
1. Implement formal patch management process
2. Critical patches within 14 days, high within 30 days
3. Regular vulnerability scanning (weekly for external, monthly for internal)
4. Complete asset inventory
5. Identify and remediate/isolate EOL systems
6. Virtual patching for systems that cannot be patched
7. Penetration testing to validate

**Owner**: _____________ **Target Date**: __________

---

### RISK #6: Third-Party / Supply Chain Compromise

**Risk Description**: Vendor or third-party with access to systems/data is compromised, leading to breach

**Asset(s) Affected**: Systems and data accessible by third parties

**Threat Actor**: ☑ External Attacker (via compromised vendor)

**Vulnerability**:
- Inadequate vendor security assessment
- Excessive vendor access
- No vendor monitoring
- Weak contracts (no security requirements)

**Current Controls**:
☐ Vendor risk assessment process
☐ Security requirements in contracts
☐ Vendor access monitoring
☐ Annual vendor reviews
☐ Vendor incident notification requirements

**Likelihood**: ____
- If high-risk vendors not assessed: **4**
- If basic vendor management: **3**
- If comprehensive third-party risk program: **2**

**Impact**: ____
- Vendor with broad access to sensitive data: **5**
- Vendor with limited access: **3**

**Risk Score**: ____ × ____ = ____

**Recommended Actions**:
1. Implement vendor risk assessment process
2. Require security questionnaires and audits for high-risk vendors
3. Include security requirements in all vendor contracts
4. Monitor vendor access and activity
5. Annual security reviews for critical vendors
6. Require vendor incident notification within 24 hours
7. Maintain vendor inventory with risk ratings

**Owner**: _____________ **Target Date**: __________

---

### RISK #7: Inadequate Backup / Inability to Recover

**Risk Description**: Loss of critical data or inability to recover from ransomware/disaster due to inadequate backups

**Asset(s) Affected**: All critical systems and data

**Threat Actor**: ☑ Ransomware ☑ Hardware Failure ☑ Natural Disaster ☑ Human Error

**Vulnerability**:
- No backups or infrequent backups
- Backups not tested
- Backups not protected from ransomware
- No documented RTO/RPO

**Current Controls**:
☐ Automated regular backups
☐ Offsite/cloud backup storage
☐ Immutable backups
☐ Monthly backup testing
☐ Documented RTO/RPO
☐ Backup monitoring

**Likelihood of Data Loss**: ____
- If no backups or untested: **4-5**
- If backups but not ransomware-protected: **3**
- If comprehensive backup strategy: **1-2**

**Impact**: ____
- Loss of critical business data, cannot recover: **5**
- Significant recovery time (weeks): **4**
- Can recover within RTO: **2-3**

**Risk Score**: ____ × ____ = ____

**Recommended Actions**:
1. Implement 3-2-1 backup strategy (3 copies, 2 media, 1 offsite)
2. Deploy immutable/air-gapped backups (cannot be deleted by ransomware)
3. Monthly backup restoration testing (critical systems)
4. Document and test RTO/RPO for all critical systems
5. Encrypt backups
6. Separate backup credentials from production
7. 90+ day backup retention (accounts for long ransomware dwell time)

**Owner**: _____________ **Target Date**: __________

---

### RISK #8: Cloud Misconfiguration

**Risk Description**: Misconfigured cloud services expose sensitive data or provide unauthorized access

**Asset(s) Affected**: Cloud storage (S3, Azure Blob), databases, applications

**Threat Actor**: ☑ External Attacker (scanning for exposed resources) ☑ Accidental Exposure

**Vulnerability**:
- Lack of cloud security expertise
- No cloud configuration auditing
- Default/insecure settings
- Over-permissive access

**Current Controls**:
☐ Cloud security posture management (CSPM)
☐ Infrastructure as Code (IaC) security scanning
☐ Regular cloud audits
☐ Cloud IAM properly configured
☐ Encryption enabled
☐ Logging and monitoring

**Likelihood**: ____
- If no cloud security controls: **4-5**
- If basic controls but manual: **3**
- If CSPM and automated: **2**

**Impact**: ____
- Sensitive data exposed publicly: **5**
- Internal data exposed: **3-4**

**Risk Score**: ____ × ____ = ____

**Recommended Actions**:
1. Deploy Cloud Security Posture Management (CSPM) tool
2. Conduct cloud security assessment
3. Enable encryption by default
4. Implement least privilege IAM policies
5. Regular cloud configuration audits
6. Security scanning in CI/CD pipeline
7. Cloud security training for developers/admins

**Owner**: _____________ **Target Date**: __________

---

### RISK #9: No Security Monitoring / Blind to Threats

**Risk Description**: No or limited security monitoring means incidents go undetected for extended periods

**Asset(s) Affected**: All systems (cannot detect threats)

**Threat Actor**: ☑ All (any attack can go undetected)

**Vulnerability**:
- No SIEM or centralized logging
- No 24/7 monitoring
- Logs not retained
- No threat detection

**Current Controls**:
☐ SIEM deployed
☐ 24/7 SOC (in-house or MSSP)
☐ Comprehensive log collection
☐ Threat detection rules
☐ Incident response capability

**Likelihood of Undetected Breach**: ____
- If no monitoring: **5**
- If monitoring but business hours only: **3-4**
- If 24/7 SOC: **2**

**Impact**: ____
- Undetected breach leading to extensive data theft: **5**
- Delayed detection increasing damage: **4**
- Rapid detection limiting damage: **2-3**

**Risk Score**: ____ × ____ = ____

**Recommended Actions**:
1. Implement SIEM for centralized log collection
2. Deploy EDR on all endpoints
3. Engage MSSP for 24/7 monitoring if internal SOC not feasible
4. Collect logs from all critical systems
5. 90-day log retention minimum (1 year for compliance)
6. Define and tune security alerts
7. Measure and improve MTTD (mean time to detect)

**Owner**: _____________ **Target Date**: __________

---

### RISK #10: Lack of Security Awareness / Untrained Users

**Risk Description**: Employees lack security awareness, making them susceptible to phishing, social engineering, and policy violations

**Asset(s) Affected**: All (humans are often weakest link)

**Threat Actor**: ☑ External Attacker (exploiting human vulnerability) ☑ Unintentional Insider

**Vulnerability**:
- No security training
- Training ineffective
- No testing (phishing simulations)
- Security not part of culture

**Current Controls**:
☐ Mandatory security awareness training
☐ Annual refresher training
☐ Phishing simulations
☐ Role-based training (developers, admins)
☐ New hire training

**Likelihood of Successful Social Engineering**: ____
- If no training: **5**
- If annual training only: **3-4**
- If comprehensive program with testing: **2**

**Impact**: ____
- Executive phished leading to BEC or data breach: **5**
- Employee phished leading to credential compromise: **4**
- Policy violation causing minor incident: **2-3**

**Risk Score**: ____ × ____ = ____

**Recommended Actions**:
1. Mandatory annual security awareness training (all employees)
2. Quarterly phishing simulations (track click rates)
3. Additional training for users who click (remedial)
4. Role-specific training (developers: secure coding, admins: privileged access)
5. Executive training on BEC and targeted attacks
6. Make security part of onboarding
7. Security included in performance reviews

**Owner**: _____________ **Target Date**: __________

---

## Risk Summary Dashboard

| Risk # | Risk Name | Likelihood | Impact | Risk Score | Risk Level | Owner | Status |
|--------|-----------|------------|--------|------------|------------|-------|--------|
| 1 | Ransomware Attack | | | | | | |
| 2 | Data Breach | | | | | | |
| 3 | Phishing / BEC | | | | | | |
| 4 | Insider Threat | | | | | | |
| 5 | Unpatched Vulnerabilities | | | | | | |
| 6 | Third-Party Compromise | | | | | | |
| 7 | Inadequate Backup | | | | | | |
| 8 | Cloud Misconfiguration | | | | | | |
| 9 | No Security Monitoring | | | | | | |
| 10 | Lack of Training | | | | | | |

---

## Risk Treatment Plan

### Critical Risks (Score 20-25) - Immediate Action

| Risk | Action | Owner | Target Date | Budget | Status |
|------|--------|-------|-------------|--------|--------|
| | | | | | |

### High Risks (Score 12-19) - 30 Days

| Risk | Action | Owner | Target Date | Budget | Status |
|------|--------|-------|-------------|--------|--------|
| | | | | | |

### Medium Risks (Score 6-11) - 90 Days

| Risk | Action | Owner | Target Date | Budget | Status |
|------|--------|-------|-------------|--------|--------|
| | | | | | |

### Low Risks (Score 1-5) - Monitor

| Risk | Monitoring Approach | Review Frequency |
|------|---------------------|------------------|
| | | |

---

## Risk Acceptance

For risks where treatment is not pursued:

**Risk Accepted**: _________________________________________________________________

**Rationale**: _____________________________________________________________________

**Accepted By** (requires executive approval): _____________________ **Date**: _______

**Review Date**: ____________ (risks should be reviewed annually)

---

## Appendix: Risk Assessment Scales

### Likelihood Scale

| Rating | Level | Description | Probability |
|--------|-------|-------------|-------------|
| **5** | Very Likely | Expected to occur in most circumstances | >80% |
| **4** | Likely | Will probably occur in most circumstances | 60-80% |
| **3** | Possible | Might occur at some time | 40-60% |
| **2** | Unlikely | Could occur at some time | 20-40% |
| **1** | Rare | May occur only in exceptional circumstances | <20% |

### Impact Scale

| Rating | Level | Description | Examples |
|--------|-------|-------------|----------|
| **5** | Catastrophic | Extreme impact, business survival threatened | - Ransom >$1M<br>- Data breach >100K records<br>- Regulatory fines >$1M<br>- Complete business shutdown >1 week<br>- Permanent reputation damage |
| **4** | Major | Significant impact on business operations | - Ransom $100K-$1M<br>- Data breach 10K-100K records<br>- Regulatory fines $100K-$1M<br>- Business shutdown 2-7 days<br>- Major customer loss |
| **3** | Moderate | Moderate impact, manageable | - Ransom $10K-$100K<br>- Data breach 1K-10K records<br>- Regulatory fines $10K-$100K<br>- Business disruption 1-2 days<br>- Some customer impact |
| **2** | Minor | Minor impact, easily recovered | - Ransom <$10K<br>- Data breach <1K records<br>- Fines <$10K<br>- Brief disruption <1 day<br>- Minimal customer impact |
| **1** | Negligible | Insignificant impact | - No ransom<br>- No data loss<br>- No fines<br>- No business disruption<br>- No customer impact |

---

## Sign-Off

**Risk Assessment Completed By:**

Name: _________________________ Title: _____________ Date: _________

**Reviewed and Approved By:**

CISO: _________________________ Date: _________

CIO: __________________________ Date: _________

CEO: __________________________ Date: _________

**Board Presented**: ☐ Yes ☐ No | Date: _________

---

## Document Control

**Next Review Date**: [DATE + 1 YEAR]

**Document Classification**: CONFIDENTIAL

**Version**: 1.0
