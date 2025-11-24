# Vendor Security Assessment Questionnaire

## Purpose
This questionnaire assesses the information security controls and practices of third-party vendors who will have access to [ORGANIZATION] systems, data, or facilities.

## Vendor Information

**Vendor Name**: _________________________________________________________________

**Vendor Contact**: _______________________________________________________________

**Contact Email**: ______________________________ **Phone**: _____________________

**Service Provided**: ______________________________________________________________

**Assessment Date**: ______________________________________________________________

**Assessor**: _____________________________________________________________________

---

## Questionnaire Instructions

**For Each Question:**
- ✅ **Yes** - Control is in place and documented
- ⚠️ **Partial** - Control partially implemented or not fully documented
- ❌ **No** - Control not in place
- **N/A** - Not applicable to this vendor

**Scoring:**
- **High Risk**: Multiple "No" answers in critical areas
- **Medium Risk**: Several "Partial" or "No" answers
- **Low Risk**: Mostly "Yes" answers

---

## Section 1: General Security Program

### 1.1 Security Organization

| # | Question | Yes | Partial | No | N/A | Comments/Evidence |
|---|----------|-----|---------|----|----|-------------------|
| 1.1.1 | Does your organization have a dedicated security officer/team (CISO or equivalent)? | | | | | |
| 1.1.2 | Is there a formal information security program/policy? | | | | | |
| 1.1.3 | Is the security program reviewed and updated annually? | | | | | |
| 1.1.4 | Do you conduct annual risk assessments? | | | | | |
| 1.1.5 | Is security awareness training provided to all employees? | | | | | |

**Evidence Requested:**
- Organizational chart showing security function
- Copy of Information Security Policy (or summary)
- Most recent risk assessment (executive summary)

---

### 1.2 Compliance and Certifications

| # | Question | Yes | Partial | No | N/A | Comments |
|---|----------|-----|---------|----|----|----------|
| 1.2.1 | Do you hold SOC 2 Type II certification? | | | | | |
| 1.2.2 | Are you ISO 27001 certified? | | | | | |
| 1.2.3 | Are you PCI-DSS compliant (if handling payment card data)? | | | | | |
| 1.2.4 | Are you HIPAA compliant (if handling PHI)? | | | | | |
| 1.2.5 | Do you undergo annual third-party security audits? | | | | | |
| 1.2.6 | Can you provide evidence of certifications and audit reports? | | | | | |

**Evidence Requested:**
- SOC 2 Type II report (most recent)
- ISO 27001 certificate
- PCI AOC (Attestation of Compliance)
- Other relevant certifications

---

### 1.3 Insurance

| # | Question | Yes | Partial | No | N/A | Comments |
|---|----------|-----|---------|----|----|----------|
| 1.3.1 | Do you carry cyber liability/data breach insurance? | | | | | |
| 1.3.2 | Is coverage at least $5 million? (or appropriate for your size) | | | | | |
| 1.3.3 | Can you provide certificate of insurance? | | | | | |

---

## Section 2: Data Protection

### 2.1 Data Handling

| # | Question | Yes | Partial | No | N/A | Comments |
|---|----------|-----|---------|----|----|----------|
| 2.1.1 | Do you maintain an inventory of our data in your possession? | | | | | |
| 2.1.2 | Is our data logically or physically separated from other customers' data (multi-tenancy)? | | | | | |
| 2.1.3 | Will our data be transferred or stored outside the US (or approved regions)? | | | | | |
| 2.1.4 | Do you have a data classification policy? | | | | | |
| 2.1.5 | Can you return or securely delete our data upon request? | | | | | |

---

### 2.2 Encryption

| # | Question | Yes | Partial | No | N/A | Comments |
|---|----------|-----|---------|----|----|----------|
| 2.2.1 | Is data encrypted at rest (databases, file storage)? | | | | | |
| 2.2.2 | Is data encrypted in transit (TLS 1.2 or higher)? | | | | | |
| 2.2.3 | Are encryption keys managed separately from encrypted data? | | | | | |
| 2.2.4 | Are backups encrypted? | | | | | |

**Encryption Standards Used**: ___________________________________________________

---

### 2.3 Data Loss Prevention and Backup

| # | Question | Yes | Partial | No | N/A | Comments |
|---|----------|-----|---------|----|----|----------|
| 2.3.1 | Do you have data loss prevention (DLP) controls? | | | | | |
| 2.3.2 | Are automated backups performed regularly? | | | | | |
| 2.3.3 | Are backups tested for restoration? | | | | | |
| 2.3.4 | Are backups stored offsite or in a separate location? | | | | | |
| 2.3.5 | What is your Recovery Time Objective (RTO)? | | | | | |
| 2.3.6 | What is your Recovery Point Objective (RPO)? | | | | | |

**RTO**: _______  **RPO**: _______

---

## Section 3: Access Control

### 3.1 Authentication

| # | Question | Yes | Partial | No | N/A | Comments |
|---|----------|-----|---------|----|----|----------|
| 3.1.1 | Is multi-factor authentication (MFA) required for all access? | | | | | |
| 3.1.2 | Is MFA required for administrative/privileged accounts? | | | | | |
| 3.1.3 | Are strong password requirements enforced (12+ characters, complexity)? | | | | | |
| 3.1.4 | Are passwords encrypted/hashed (not stored in plaintext)? | | | | | |
| 3.1.5 | Do you support SSO (Single Sign-On) via SAML/OIDC? | | | | | |

---

### 3.2 Authorization and Access Management

| # | Question | Yes | Partial | No | N/A | Comments |
|---|----------|-----|---------|----|----|----------|
| 3.2.1 | Is access granted based on least privilege principle? | | | | | |
| 3.2.2 | Are user access reviews conducted at least annually? | | | | | |
| 3.2.3 | Is access revoked immediately upon employee termination? | | | | | |
| 3.2.4 | Are privileged accounts managed separately from standard accounts? | | | | | |
| 3.2.5 | Do you log and monitor administrative actions? | | | | | |

---

### 3.3 Remote Access

| # | Question | Yes | Partial | No | N/A | Comments |
|---|----------|-----|---------|----|----|----------|
| 3.3.1 | Is VPN or equivalent secure access required for remote connections? | | | | | |
| 3.3.2 | Are remote desktop protocols (RDP, SSH) secured and not exposed to internet? | | | | | |
| 3.3.3 | Are remote access sessions logged and monitored? | | | | | |

---

## Section 4: Security Operations

### 4.1 Vulnerability and Patch Management

| # | Question | Yes | Partial | No | N/A | Comments |
|---|----------|-----|---------|----|----|----------|
| 4.1.1 | Do you conduct regular vulnerability scans? | | | | | |
| 4.1.2 | How quickly are critical vulnerabilities patched? | | | | | |
| 4.1.3 | How quickly are high severity vulnerabilities patched? | | | | | |
| 4.1.4 | Do you conduct annual penetration testing? | | | | | |
| 4.1.5 | Can you provide summary of most recent pen test results? | | | | | |

**Patching SLAs**: Critical: ____ days, High: ____ days, Medium: ____ days

---

### 4.2 Monitoring and Logging

| # | Question | Yes | Partial | No | N/A | Comments |
|---|----------|-----|---------|----|----|----------|
| 4.2.1 | Do you have a Security Operations Center (SOC) or equivalent? | | | | | |
| 4.2.2 | Is security monitoring performed 24/7? | | | | | |
| 4.2.3 | Do you use a SIEM (Security Information and Event Management) system? | | | | | |
| 4.2.4 | Are security logs retained for at least 90 days? | | | | | |
| 4.2.5 | Do you use intrusion detection/prevention systems (IDS/IPS)? | | | | | |
| 4.2.6 | Do you have endpoint detection and response (EDR) on all devices? | | | | | |

---

### 4.3 Malware Protection

| # | Question | Yes | Partial | No | N/A | Comments |
|---|----------|-----|---------|----|----|----------|
| 4.3.1 | Is antivirus/antimalware deployed on all endpoints and servers? | | | | | |
| 4.3.2 | Are malware signatures updated automatically? | | | | | |
| 4.3.3 | Is email scanned for malicious content? | | | | | |
| 4.3.4 | Are web downloads scanned? | | | | | |

---

## Section 5: Network Security

### 5.1 Network Architecture

| # | Question | Yes | Partial | No | N/A | Comments |
|---|----------|-----|---------|----|----|----------|
| 5.1.1 | Is your network segmented (production, development, corporate)? | | | | | |
| 5.1.2 | Are firewalls deployed between network segments? | | | | | |
| 5.1.3 | Is a DMZ used for internet-facing systems? | | | | | |
| 5.1.4 | Are wireless networks encrypted (WPA2 or WPA3)? | | | | | |
| 5.1.5 | Is guest wireless isolated from corporate network? | | | | | |

---

### 5.2 Application Security

| # | Question | Yes | Partial | No | N/A | Comments |
|---|----------|-----|---------|----|----|----------|
| 5.2.1 | Do you follow secure development lifecycle practices? | | | | | |
| 5.2.2 | Is code reviewed for security before production deployment? | | | | | |
| 5.2.3 | Do you perform static/dynamic application security testing? | | | | | |
| 5.2.4 | Are web applications protected by WAF (Web Application Firewall)? | | | | | |
| 5.2.5 | Do you test for OWASP Top 10 vulnerabilities? | | | | | |
| 5.2.6 | Are APIs secured with authentication and encryption? | | | | | |

---

## Section 6: Physical and Environmental Security

### 6.1 Physical Security

| # | Question | Yes | Partial | No | N/A | Comments |
|---|----------|-----|---------|----|----|----------|
| 6.1.1 | Are data centers physically secured with access controls? | | | | | |
| 6.1.2 | Is visitor access logged and monitored? | | | | | |
| 6.1.3 | Are security cameras deployed? | | | | | |
| 6.1.4 | Is 24/7 physical security staff present? | | | | | |

---

### 6.1.2 Data Center (if applicable)

| # | Question | Yes | Partial | No | N/A | Comments |
|---|----------|-----|---------|----|----|----------|
| 6.1.5 | Do you use third-party data centers? If yes, which? | | | | | |
| 6.1.6 | Are data centers Tier III or higher? | | | | | |
| 6.1.7 | Is environmental monitoring in place (temperature, humidity)? | | | | | |
| 6.1.8 | Are fire suppression systems present? | | | | | |
| 6.1.9 | Is backup power (UPS, generators) available? | | | | | |

**Data Center Locations**: ________________________________________________________

---

## Section 7: Incident Response and Business Continuity

### 7.1 Incident Response

| # | Question | Yes | Partial | No | N/A | Comments |
|---|----------|-----|---------|----|----|----------|
| 7.1.1 | Do you have a documented incident response plan? | | | | | |
| 7.1.2 | Is the plan tested at least annually? | | | | | |
| 7.1.3 | Do you have a 24/7 security incident response team? | | | | | |
| 7.1.4 | Have you experienced a security incident in the past 2 years? | | | | | |
| 7.1.5 | Will you notify us within 24 hours of incident affecting our data? | | | | | |
| 7.1.6 | Do you have cyber insurance? | | | | | |

**If security incident occurred, please describe**: ___________________________________
________________________________________________________________________________
________________________________________________________________________________

**Incident Notification Contact**: ________________________________________________

---

### 7.2 Business Continuity and Disaster Recovery

| # | Question | Yes | Partial | No | N/A | Comments |
|---|----------|-----|---------|----|----|----------|
| 7.2.1 | Do you have a business continuity plan (BCP)? | | | | | |
| 7.2.2 | Do you have a disaster recovery plan (DRP)? | | | | | |
| 7.2.3 | Are BCP/DRP tested annually? | | | | | |
| 7.2.4 | Do you have a secondary/backup site? | | | | | |
| 7.2.5 | What is your RTO (Recovery Time Objective) for our service? | | | | | |
| 7.2.6 | What is your RPO (Recovery Point Objective)? | | | | | |

**RTO**: _______ **RPO**: _______

---

## Section 8: Human Resources Security

### 8.1 Personnel Security

| # | Question | Yes | Partial | No | N/A | Comments |
|---|----------|-----|---------|----|----|----------|
| 8.1.1 | Do you conduct background checks on employees? | | | | | |
| 8.1.2 | Are employees required to sign confidentiality agreements (NDAs)? | | | | | |
| 8.1.3 | Do employees receive security awareness training annually? | | | | | |
| 8.1.4 | Is role-specific security training provided (developers, admins)? | | | | | |
| 8.1.5 | Is there a secure termination process (immediate access revocation)? | | | | | |

---

### 8.2 Third-Party Personnel

| # | Question | Yes | Partial | No | N/A | Comments |
|---|----------|-----|---------|----|----|----------|
| 8.2.1 | Do you use subcontractors or offshore resources? | | | | | |
| 8.2.2 | Are subcontractors subject to same security requirements? | | | | | |
| 8.2.3 | Will you notify us before engaging subcontractors with access to our data? | | | | | |

**Subcontractor Locations**: ______________________________________________________

---

## Section 9: Third-Party and Supply Chain

### 9.1 Vendor Management

| # | Question | Yes | Partial | No | N/A | Comments |
|---|----------|-----|---------|----|----|----------|
| 9.1.1 | Do you have a vendor risk management program? | | | | | |
| 9.1.2 | Do you assess security of your vendors/suppliers? | | | | | |
| 9.1.3 | Are security requirements included in vendor contracts? | | | | | |
| 9.1.4 | Do you monitor vendor compliance? | | | | | |

---

## Section 10: Cloud and SaaS (if applicable)

### 10.1 Cloud Security

| # | Question | Yes | Partial | No | N/A | Comments |
|---|----------|-----|---------|----|----|----------|
| 10.1.1 | Which cloud providers do you use? | | | | | |
| 10.1.2 | Are cloud configurations audited regularly? | | | | | |
| 10.1.3 | Is data encrypted in cloud storage? | | | | | |
| 10.1.4 | Do you use cloud security posture management (CSPM) tools? | | | | | |
| 10.1.5 | Are cloud access and activities logged and monitored? | | | | | |

**Cloud Providers Used**: __________________________________________________________

---

## Section 11: Privacy and Regulatory Compliance

### 11.1 Privacy

| # | Question | Yes | Partial | No | N/A | Comments |
|---|----------|-----|---------|----|----|----------|
| 11.1.1 | Do you have a privacy policy? | | | | | |
| 11.1.2 | Are you GDPR compliant (if handling EU data)? | | | | | |
| 11.1.3 | Are you CCPA compliant (if handling CA resident data)? | | | | | |
| 11.1.4 | Can you support data subject rights requests (access, deletion)? | | | | | |
| 11.1.5 | Do you have a Data Protection Officer (DPO) or equivalent? | | | | | |

---

### 11.2 Regulatory Compliance

| # | Question | Yes | Partial | No | N/A | Comments |
|---|----------|-----|---------|----|----|----------|
| 11.2.1 | What regulations apply to your organization? | | | | | |
| 11.2.2 | Are you compliant with applicable regulations? | | | | | |
| 11.2.3 | Have you had any regulatory violations or fines in past 2 years? | | | | | |

**Applicable Regulations**: ☐ GDPR ☐ HIPAA ☐ PCI-DSS ☐ SOX ☐ CCPA ☐ Other: _______

---

## Assessment Results

### Scoring Summary

| Section | Total Questions | Yes | Partial | No | N/A | Score |
|---------|----------------|-----|---------|----|----|-------|
| 1. General Security | | | | | | |
| 2. Data Protection | | | | | | |
| 3. Access Control | | | | | | |
| 4. Security Operations | | | | | | |
| 5. Network Security | | | | | | |
| 6. Physical Security | | | | | | |
| 7. Incident Response & BC | | | | | | |
| 8. Human Resources | | | | | | |
| 9. Third-Party Mgmt | | | | | | |
| 10. Cloud Security | | | | | | |
| 11. Privacy & Compliance | | | | | | |
| **TOTAL** | | | | | | |

**Score Calculation**: (Yes × 1) + (Partial × 0.5) / (Total - N/A) × 100 = ______%

---

### Risk Rating

Based on responses and scoring:

☐ **LOW RISK** (Score >85%)
- Comprehensive security program
- All critical controls in place
- Minor gaps only
- **Recommendation**: Approve with annual review

☐ **MEDIUM RISK** (Score 70-85%)
- Adequate security program
- Some gaps in controls
- Mitigation possible
- **Recommendation**: Approve with conditions and 6-month review

☐ **HIGH RISK** (Score <70%)
- Significant security gaps
- Multiple critical controls missing
- Unacceptable risk
- **Recommendation**: Do not approve unless vendor commits to remediation plan

---

### Critical Findings

**Issues Requiring Immediate Attention:**

1. _____________________________________________________________________________
   **Risk**: ___________________________________________________________________
   **Remediation**: ____________________________________________________________

2. _____________________________________________________________________________
   **Risk**: ___________________________________________________________________
   **Remediation**: ____________________________________________________________

3. _____________________________________________________________________________
   **Risk**: ___________________________________________________________________
   **Remediation**: ____________________________________________________________

---

### Recommendations

**Contractual Requirements:**
- [ ] Include security requirements in contract
- [ ] Require incident notification within 24 hours
- [ ] Right to audit vendor security
- [ ] Data ownership and return/deletion provisions
- [ ] Liability and indemnification for security breaches
- [ ] Compliance with our security policies
- [ ] Annual security reassessment

**Monitoring:**
- [ ] Quarterly security reviews
- [ ] Annual SOC 2 report review
- [ ] Monitor for security incidents/breaches
- [ ] Review access logs periodically

**Remediation Plan (if applicable):**
- [ ] Vendor to provide remediation plan for identified gaps
- [ ] Remediation deadline: ______________
- [ ] Re-assessment after remediation

---

## Approval

**Assessment Completed By:**

Name: _________________________ Title: _____________ Date: _________

**Reviewed By:**

Security/Risk Manager: _________________________ Date: _________

**Decision:**

☐ **APPROVED** - Vendor meets security requirements

☐ **APPROVED WITH CONDITIONS** - Vendor must address:
__________________________________________________________________________________
__________________________________________________________________________________

☐ **REJECTED** - Vendor does not meet minimum security requirements

**Approved By:**

CISO: _________________________ Date: _________

CIO: __________________________ Date: _________

---

## Next Review Date: ______________

---

## Attachments/Evidence

**Documents Received:**
- [ ] SOC 2 Type II Report
- [ ] ISO 27001 Certificate
- [ ] PCI AOC (if applicable)
- [ ] Cyber Insurance Certificate
- [ ] Other: _________________

**Filed**: __________ **Document Location**: __________

---

**Document Classification**: CONFIDENTIAL
**Version**: 1.0
