# Incident Response Plan Template
## [Organization Name]

**Document Version**: 1.0
**Last Updated**: [DATE]
**Next Review Date**: [DATE + 1 YEAR]
**Document Owner**: [CISO NAME]
**Approval**: [CEO/BOARD]

---

## Table of Contents

1. [Purpose and Scope](#purpose-and-scope)
2. [Incident Response Team](#incident-response-team)
3. [Incident Classification](#incident-classification)
4. [Incident Response Process](#incident-response-process)
5. [Incident Types and Procedures](#incident-types-and-procedures)
6. [Communication Protocols](#communication-protocols)
7. [External Resources](#external-resources)
8. [Post-Incident Activities](#post-incident-activities)
9. [Appendices](#appendices)

---

## 1. Purpose and Scope

### Purpose
This Incident Response Plan defines the procedures and responsibilities for responding to cybersecurity incidents affecting [ORGANIZATION NAME]. The plan aims to:
- Minimize business disruption and data loss
- Preserve evidence for investigation
- Comply with legal and regulatory requirements
- Enable rapid recovery
- Learn from incidents to improve security posture

### Scope
This plan applies to all information security incidents affecting:
- Information systems (servers, workstations, mobile devices, cloud services)
- Data (customer data, intellectual property, employee information)
- Networks and infrastructure
- Applications and services

### Definitions

**Security Incident**: Any event that compromises the confidentiality, integrity, or availability of information assets, including but not limited to:
- Unauthorized access to systems or data
- Malware infections
- Ransomware attacks
- Data breaches
- Denial of service attacks
- Insider threats
- Physical security breaches affecting IT assets

---

## 2. Incident Response Team

### Core Incident Response Team

| Role | Name | Primary Phone | Backup Phone | Email | Availability |
|------|------|--------------|--------------|-------|--------------|
| **Incident Commander** | [NAME] | [PHONE] | [PHONE] | [EMAIL] | 24/7 |
| **CISO/Security Lead** | [NAME] | [PHONE] | [PHONE] | [EMAIL] | 24/7 |
| **IT Director/CIO** | [NAME] | [PHONE] | [PHONE] | [EMAIL] | 24/7 |
| **Legal Counsel** | [NAME] | [PHONE] | [PHONE] | [EMAIL] | 24/7 |
| **HR Representative** | [NAME] | [PHONE] | [PHONE] | [EMAIL] | On-call |
| **PR/Communications** | [NAME] | [PHONE] | [PHONE] | [EMAIL] | On-call |
| **Business Continuity** | [NAME] | [PHONE] | [PHONE] | [EMAIL] | On-call |

### Extended Team (As Needed)

| Role | Name | Contact | When to Engage |
|------|------|---------|----------------|
| **CEO** | [NAME] | [CONTACT] | Major incidents, board notification required |
| **CFO** | [NAME] | [CONTACT] | Financial impact, insurance claims |
| **Compliance Officer** | [NAME] | [CONTACT] | Regulatory reporting required |
| **Facilities/Physical Security** | [NAME] | [CONTACT] | Physical access required |
| **Database Administrator** | [NAME] | [CONTACT] | Database compromise suspected |
| **Network Engineer** | [NAME] | [CONTACT] | Network-related incidents |
| **Cloud Administrator** | [NAME] | [CONTACT] | Cloud service incidents |

### Roles and Responsibilities

**Incident Commander:**
- Overall incident management and coordination
- Authorize actions and resource allocation
- Escalate to executive leadership
- Make critical decisions (system shutdown, ransom payment, law enforcement notification)
- Ensure documentation

**CISO/Security Lead:**
- Technical security guidance
- Coordinate investigation and forensics
- Interface with security vendors
- Assess severity and scope
- Recommend containment and remediation

**IT Director/CIO:**
- System and infrastructure actions
- Coordinate IT staff
- Assess business impact
- Recovery efforts
- Balance security and business needs

**Legal Counsel:**
- Legal and regulatory guidance
- Breach notification requirements
- Law enforcement coordination
- Litigation hold
- Privilege and work product protection
- Contract review (insurance, vendors)

**HR Representative:**
- Insider threat investigations
- Employee relations
- Witness interviews
- Policy enforcement
- Background checks (if needed)

**PR/Communications:**
- Internal communications
- External communications (customers, media, public)
- Social media monitoring
- Reputation management
- Message development

**Business Continuity:**
- Business impact assessment
- Activation of business continuity plans
- Alternate process coordination
- Recovery prioritization

---

## 3. Incident Classification

### Severity Levels

| Level | Definition | Examples | Response Time | Escalation |
|-------|------------|----------|---------------|------------|
| **P1 - Critical** | Severe impact on business operations or high risk of data breach | Ransomware, active data breach, complete system outage | Immediate (minutes) | CEO, Board |
| **P2 - High** | Significant impact on operations or moderate breach risk | Malware outbreak, partial system compromise | 1 hour | Executive team |
| **P3 - Medium** | Limited impact, contained incident | Single malware infection, attempted breach | 4 hours | Management |
| **P4 - Low** | Minimal impact, informational | Policy violation, suspicious activity | 24 hours | Team lead |

### Incident Categories

**Category 1: Malware/Ransomware**
- Virus, trojan, worm, ransomware
- Examples: WannaCry, Emotet, TrickBot

**Category 2: Unauthorized Access**
- Compromised credentials
- Privilege escalation
- Insider threat

**Category 3: Data Breach/Exfiltration**
- Unauthorized data access
- Data theft
- Data exposure (misconfiguration)

**Category 4: Denial of Service**
- DDoS attacks
- Resource exhaustion
- Service disruption

**Category 5: Phishing/Social Engineering**
- Email phishing
- Spear phishing
- Business Email Compromise (BEC)
- Vishing/Smishing

**Category 6: Web Application Attack**
- SQL injection
- Cross-site scripting (XSS)
- Application vulnerability exploitation

**Category 7: Insider Threat**
- Malicious insider
- Negligent insider
- Data theft by employee

**Category 8: Physical Security**
- Theft of devices
- Unauthorized physical access
- Lost/stolen laptops or mobile devices

**Category 9: Third-Party/Supply Chain**
- Vendor compromise
- Supply chain attack
- Cloud service breach

---

## 4. Incident Response Process

### Overview

The incident response process follows six phases:

```
1. DETECTION → 2. TRIAGE → 3. CONTAINMENT → 4. ERADICATION → 5. RECOVERY → 6. LESSONS LEARNED
```

---

### Phase 1: DETECTION

**Objective**: Identify potential security incidents

**Detection Sources:**
- Security monitoring tools (SIEM, IDS/IPS, EDR)
- User reports
- Antivirus alerts
- Log analysis
- Third-party notifications
- External researchers

**Actions:**
- [ ] Receive alert or notification
- [ ] Document incident details (time, source, description)
- [ ] Assign initial severity assessment
- [ ] Create incident ticket

**Timeline**: Ongoing / As alerts occur

---

### Phase 2: TRIAGE & ANALYSIS

**Objective**: Validate and assess the incident

**Actions:**
- [ ] Verify incident is legitimate (not false positive)
- [ ] Classify incident type and severity
- [ ] Activate incident response team (based on severity)
- [ ] Establish incident command center (virtual or physical)
- [ ] Begin incident log
- [ ] Perform initial scope assessment:
  - What systems are affected?
  - What data is at risk?
  - Is attacker still present?
  - What is the business impact?

**Decision Point**: Escalate or handle as normal ticket?

**Timeline**: 15 minutes to 2 hours depending on severity

---

### Phase 3: CONTAINMENT

**Objective**: Stop the incident from spreading while preserving evidence

**Short-Term Containment (Immediate):**
- [ ] Isolate affected systems (disconnect from network)
  - **NOTE**: Do NOT power off (may lose evidence in memory)
- [ ] Block malicious IP addresses at firewall
- [ ] Disable compromised user accounts
- [ ] Revoke compromised credentials
- [ ] Increase monitoring on related systems
- [ ] Preserve evidence:
  - Take memory dumps
  - Capture network traffic
  - Save log files
  - Document all actions with timestamps

**Long-Term Containment:**
- [ ] Apply temporary fixes to allow business continuity
- [ ] Implement additional monitoring
- [ ] Segment network further if needed
- [ ] Deploy additional security controls

**Decision Point**: Is containment successful? Can we move to eradication?

**Timeline**: 1-24 hours depending on incident

---

### Phase 4: ERADICATION

**Objective**: Remove the threat from the environment

**Actions:**
- [ ] Identify root cause
- [ ] Remove malware/backdoors
- [ ] Close attack vector:
  - Patch vulnerabilities
  - Fix misconfigurations
  - Disable unnecessary services
- [ ] Reset compromised credentials (all potentially affected)
- [ ] Review and update firewall rules
- [ ] Verify threat is completely removed

**Evidence Collection:**
- [ ] Complete forensic analysis
- [ ] Document timeline of attack
- [ ] Identify data accessed/exfiltrated
- [ ] Determine attack attribution (if possible)

**Timeline**: Hours to days depending on complexity

---

### Phase 5: RECOVERY

**Objective**: Restore systems to normal operations

**Actions:**
- [ ] Verify systems are clean
- [ ] Restore from clean backups (if applicable)
- [ ] Rebuild compromised systems
- [ ] Re-enable disabled accounts (with new credentials)
- [ ] Gradually restore services (monitor for re-infection)
- [ ] Enhanced monitoring for 30 days post-incident
- [ ] Conduct functionality testing
- [ ] Obtain business unit sign-off

**Validation:**
- [ ] Systems operating normally
- [ ] No signs of re-infection
- [ ] Business processes restored
- [ ] Additional security controls in place

**Timeline**: Days to weeks depending on impact

---

### Phase 6: LESSONS LEARNED

**Objective**: Improve security posture and response capabilities

**Post-Incident Review Meeting** (Within 2 weeks of incident close)

**Attendees:** Incident response team + relevant stakeholders

**Agenda:**
1. **Incident Timeline Review**
   - How did it happen?
   - When was it detected?
   - What was the response?

2. **What Worked Well?**
   - Effective detections
   - Successful containment
   - Good communication

3. **What Didn't Work?**
   - Missed detections
   - Slow response
   - Communication gaps
   - Resource constraints

4. **Root Cause Analysis**
   - What allowed this to happen?
   - Were controls in place?
   - Were controls effective?

5. **Recommendations**
   - Technical improvements
   - Process improvements
   - Policy updates
   - Training needs

6. **Action Items**
   - Assign owners
   - Set deadlines
   - Track to completion

**Deliverables:**
- [ ] Incident report
- [ ] Lessons learned document
- [ ] Updated security controls
- [ ] Updated incident response plan (if needed)
- [ ] Training materials (if needed)

**Timeline**: Within 2 weeks of incident closure

---

## 5. Incident Types and Specific Procedures

### Ransomware Incident

**Immediate Actions (First Hour):**
1. **DO NOT shut down infected systems** (may lose decryption key in memory)
2. **Isolate immediately**:
   - Disconnect from network (pull cable or disable WiFi)
   - Disable all user accounts
   - Block command & control IPs at firewall
3. **Preserve evidence**:
   - Take memory dump (if expertise available)
   - Save ransom note
   - Screenshot encryption messages
   - Document affected systems
4. **Activate incident response team**:
   - CISO, IT Director, Legal Counsel, CEO
   - Establish command center
5. **Notify stakeholders**:
   - Executive team
   - Cyber insurance carrier (IMMEDIATELY - required for coverage)
   - Law enforcement (FBI - IC3.gov)
   - Incident response retainer firm (if applicable)

**Assessment Actions (Hours 2-4):**
1. **Determine scope**:
   - How many systems encrypted?
   - Is encryption still spreading?
   - Are backups affected?
   - What data is encrypted?
2. **Identify ransomware variant**:
   - Use ID Ransomware (https://id-ransomware.malwarehunterteam.com/)
   - Check for known decryptors (No More Ransom Project)
3. **Assess recovery options**:
   - Are backups available and clean?
   - How long to restore?
   - Business impact of downtime?
4. **Do NOT contact attacker yet** (may encourage demands)

**Decision Point: Pay or Not Pay? (Hours 4-24)**

**Factors to Consider:**

*Arguments Against Paying:*
- ❌ No guarantee of decryption
- ❌ Funds criminal activity
- ❌ Encourages future attacks
- ❌ May violate sanctions (OFAC)
- ❌ Decryption often incomplete
- ❌ Data may still be published (double extortion)

*Arguments For Paying (ONLY in extreme cases):*
- ✅ No other recovery option
- ✅ Critical business impact (lives at risk in healthcare)
- ✅ Restore time unacceptable
- ✅ Insurance covers payment

**Decision Makers**: CEO, Board, Legal Counsel, CISO

**If Payment Decided:**
- Consult with law enforcement and legal counsel
- Check OFAC sanctions list
- Use negotiator (ransom is negotiable, expect 30-50% discount)
- Obtain proof of decryption before full payment
- Still restore from backups as primary method
- Document all decisions

**Recovery:**
- Restore from backups (preferred method)
- If paying ransom, obtain decryptor
- Rebuild all compromised systems
- Reset all credentials
- Enhance security controls
- Monitor for re-infection (30 days)

**Notification Requirements:**
- Regulatory notifications (if data exfiltrated)
- Customer notifications (if data exfiltrated)
- Insurance claim
- Law enforcement report

---

### Data Breach Incident

**Immediate Actions (First Hour):**
1. **Confirm breach**:
   - Verify data accessed
   - Determine data types (PII, PHI, financial, IP)
   - Assess sensitivity and number of records
2. **Contain breach**:
   - Close attack vector
   - Revoke compromised credentials
   - Block attacker access
3. **Preserve evidence**:
   - Don't delete logs
   - Take forensic images
   - Document findings
4. **Activate incident response team + Legal Counsel**:
   - Attorney-client privilege
   - Breach counsel recommended

**Assessment Actions (Hours 2-24):**
1. **Scope determination**:
   - What data was accessed?
   - How many individuals affected?
   - Was data exfiltrated or just accessed?
   - When did breach occur? (dwell time)
2. **Legal and regulatory review**:
   - What notification laws apply?
   - Timeline requirements
   - Regulatory reporting obligations
   - Potential fines/penalties
3. **Forensic investigation**:
   - How did breach occur?
   - What vulnerabilities exploited?
   - Attribution
   - Complete timeline

**Notification Determination (Days 1-7):**

**Regulatory Notifications:**
- [ ] HIPAA breach (if PHI involved): HHS within 60 days if >500 individuals
- [ ] State breach laws: Various timelines (typically 30-90 days)
- [ ] GDPR (if EU data): DPA within 72 hours
- [ ] Other regulatory bodies

**Individual Notifications:**
- [ ] Affected individuals: Required by most breach laws
- [ ] Content: What happened, what data, steps being taken, resources (credit monitoring)
- [ ] Method: Mail, email (check state requirements)
- [ ] Timeline: Typically 30-90 days, "without unreasonable delay"

**Other Notifications:**
- [ ] Law enforcement (optional but recommended)
- [ ] Credit bureaus (if >1,000 individuals)
- [ ] Media (if required by state law, typically if >1,000 state residents affected)

**Communication Plan:**
- [ ] Draft notification letters/emails
- [ ] Set up dedicated hotline
- [ ] Create FAQ
- [ ] Prepare talking points for customer service
- [ ] Media statement (if needed)
- [ ] Website disclosure (if required)

**Remediation:**
- Fix vulnerabilities
- Enhance security controls
- Offer credit monitoring (12-24 months typical)
- Update policies and procedures

**Long-Term:**
- Regulatory inquiries and audits
- Class action lawsuits (likely)
- Insurance claims
- Reputation management

---

### Insider Threat Incident

**Detection Indicators:**
- Unusual data downloads
- Access to data outside normal role
- Attempts to bypass security controls
- After-hours access
- Use of personal USB drives/cloud storage
- Resume updates (LinkedIn)
- Disgruntlement or negative workplace events

**Immediate Actions:**
1. **Do NOT alert the suspect**:
   - Covert investigation initially
   - Coordinate with HR and Legal
2. **Preserve evidence**:
   - Forensic copy of suspect's devices
   - Email and file access logs
   - Network traffic
   - Badge swipe logs
3. **Assess risk**:
   - What data has been accessed?
   - Is data leaving the organization?
   - Is suspect still accessing systems?
4. **Assemble investigation team**:
   - HR, Legal, Security, Management
   - Consider external investigators

**Investigation Actions:**
1. **Data analysis**:
   - Review access logs
   - Email investigation
   - Cloud storage checks
   - USB device usage
   - Print logs
2. **Interviews**:
   - Witnesses (colleagues)
   - Manager
   - Suspect (carefully, with HR and Legal present)

**Containment (if confirmed):**
1. **Access revocation**:
   - Disable accounts
   - Collect devices
   - Retrieve badge
2. **Evidence seizure**:
   - Laptop, phone, USB drives
   - Personal devices (if company data suspected)
3. **Document everything**:
   - Chain of custody
   - Witness statements
   - All actions taken

**Decision Points:**
- Termination?
- Law enforcement referral?
- Civil lawsuit?
- Criminal charges?

**Legal Considerations:**
- Consult employment attorney
- Document policy violations
- Privacy concerns (employee monitoring)
- Potential wrongful termination claims
- Non-disparagement considerations

---

### Phishing Incident

**User Reports Suspicious Email:**
1. **Do NOT click links or open attachments**
2. **Report to security team** (via dedicated email or button)
3. **Do NOT delete** (security needs to analyze)

**Security Team Response:**
1. **Analyze email**:
   - Sender analysis
   - Link analysis (VirusTotal, URLScan.io)
   - Attachment analysis (sandbox)
   - Determine if malicious
2. **If malicious**:
   - [ ] Identify all recipients
   - [ ] Remove from all inboxes (if possible)
   - [ ] Block sender domain/address
   - [ ] Add indicators to security tools
   - [ ] Send warning to all employees
3. **If credentials entered**:
   - [ ] Force password reset immediately
   - [ ] Review account activity for compromise
   - [ ] Enable additional monitoring

**Business Email Compromise (BEC):**
- Attacker impersonates executive or vendor
- Requests wire transfer or sensitive data
- **Financial Controls are critical**: Dual approval, callback verification

**If BEC Successful (Fraudulent Wire Transfer):**
1. **Immediate actions**:
   - Contact bank immediately (within 24 hours critical)
   - Request recall/reversal
   - Contact receiving bank
   - Law enforcement (FBI, local police)
2. **Investigation**:
   - Email compromise or spoofing?
   - How did attacker know?
   - Internal information leak?
3. **Prevention**:
   - Out-of-band verification for wire transfers
   - Dual approval for large transfers
   - Training on BEC tactics

---

## 6. Communication Protocols

### Internal Communication

**Communication Hierarchy:**
```
Incident Response Team
       ↓
   Management
       ↓
   All Employees
```

**Communication Channels:**
- Primary: Dedicated Slack/Teams channel
- Secondary: Conference bridge
- Emergency: SMS/phone tree

**Incident Status Updates:**
- **Critical (P1)**: Every hour
- **High (P2)**: Every 4 hours
- **Medium (P3)**: Daily
- **Low (P4)**: As needed

**What to Communicate:**
- What happened (high-level, appropriate detail for audience)
- Current status
- Business impact
- Actions being taken
- When next update expected
- What employees should do

**Internal Communication Templates:**

**Initial Notification (Management):**
```
Subject: [CONFIDENTIAL] Security Incident Notification

An information security incident has been identified:

Incident: [Brief description]
Severity: [P1/P2/P3/P4]
Systems Affected: [List]
Business Impact: [Current impact]
Status: [Investigation/Containment/Recovery]
Incident Commander: [Name]

The incident response team has been activated and is working to contain and resolve the situation.

Next Update: [Time]

For questions, contact: [Incident Commander contact]
```

**All-Employee Notification (if needed):**
```
Subject: Security Alert - Action Required

We are responding to a security incident affecting [description of impact].

What You Need to Know:
- [Key point 1]
- [Key point 2]
- [Key point 3]

What You Should Do:
- [Action 1]
- [Action 2]
- [Action 3]

What We Are Doing:
- [Response action 1]
- [Response action 2]

We take this matter seriously and are working diligently to resolve it.

If you have questions or concerns, please contact: [Contact method]
```

---

### External Communication

**Customer Communication:**

**When to Notify Customers:**
- Customer data affected
- Service disruption impacting customers
- Regulatory requirement
- Media coverage likely

**Communication Method:**
- Email (primary)
- Website notice
- Direct phone calls (high-value customers)
- Social media (if appropriate)

**Customer Communication Template:**
```
Subject: Important Security Notice

Dear [Customer],

We are writing to inform you of a security incident that may affect your information.

What Happened:
[Concise description of incident]

What Information Was Involved:
[Specific data types: names, email addresses, etc.]

What We Are Doing:
- [Action 1]
- [Action 2]
- [Action 3]

What You Can Do:
- [Recommendation 1 - e.g., reset password]
- [Recommendation 2 - e.g., monitor accounts]
- [Offer credit monitoring if applicable]

For More Information:
- Dedicated hotline: [PHONE]
- FAQ: [URL]
- Email: [EMAIL]

We sincerely apologize for this incident and any concern it may cause. We take the security of your information seriously.

Sincerely,
[Executive Name]
[Title]
```

---

**Media Communication:**

**Spokesperson**: CEO or designated communications officer ONLY

**Media Statement Template:**
```
[COMPANY NAME] Statement on Security Incident

[COMPANY] recently became aware of a security incident affecting [description].

We immediately launched an investigation with the assistance of leading cybersecurity experts and are working with law enforcement.

We are taking this matter very seriously and have implemented additional security measures to protect against future incidents.

We are in the process of notifying affected individuals and are offering [credit monitoring / identity protection services].

Protecting our customers' information is a top priority, and we sincerely apologize for this incident.

For more information: [URL or contact]
```

**Media Dos and Don'ts:**

**DO:**
- Stick to approved talking points
- Be empathetic and apologetic
- Focus on actions being taken
- Direct to dedicated resources (website, hotline)
- Correct misinformation

**DON'T:**
- Speculate or guess
- Minimize the incident
- Blame others (vendors, employees)
- Provide technical details
- Make promises you can't keep
- Say "no comment" (looks guilty)

---

### Regulatory Communication

**Breach Notification Requirements (US):**

**HIPAA (Healthcare):**
- **Trigger**: Breach of unsecured PHI
- **Timeline**:
  - >500 individuals: HHS within 60 days
  - <500 individuals: Annual reporting
  - Media notification if >500 in state/jurisdiction
  - Individual notification: 60 days
- **Method**: Submit via HHS Breach Portal
- **Contact**: HHS Office for Civil Rights

**State Breach Laws (Example: California):**
- **Trigger**: Unauthorized access to unencrypted PI
- **Timeline**: Without unreasonable delay
- **Notification**: State Attorney General if >500 CA residents
- **Individual notification**: Required

**GDPR (EU):**
- **Trigger**: Personal data breach likely to result in risk
- **Timeline**:
  - Data Protection Authority: 72 hours
  - Individuals: Without undue delay (if high risk)
- **Penalties**: Up to €20M or 4% of global turnover

**Regulatory Notification Checklist:**
- [ ] Identify all applicable regulations
- [ ] Calculate notification deadlines
- [ ] Prepare notification content (with legal review)
- [ ] Submit to regulators
- [ ] Document submission (date, method, recipient)
- [ ] Respond to regulator follow-up inquiries
- [ ] Maintain all correspondence

---

## 7. External Resources

### Incident Response Retainers (Recommended)

**Breach Counsel:**
- Firm: [LAW FIRM NAME]
- Contact: [ATTORNEY NAME]
- Phone: [PHONE]
- Email: [EMAIL]
- Retainer: [YES/NO]

**Digital Forensics:**
- Firm: [FORENSICS FIRM]
- Contact: [CONTACT]
- Phone: [PHONE - 24/7]
- Email: [EMAIL]
- Retainer: [YES/NO]

**Crisis Communications/PR:**
- Firm: [PR FIRM]
- Contact: [CONTACT]
- Phone: [PHONE]
- Email: [EMAIL]

**Cyber Insurance:**
- Carrier: [INSURANCE COMPANY]
- Policy Number: [NUMBER]
- Claims Contact: [PHONE/EMAIL]
- Coverage: [SUMMARY]
- **IMPORTANT**: Notify insurance within 24 hours of major incident

---

### Law Enforcement Contacts

**FBI Internet Crime Complaint Center (IC3):**
- Website: https://www.ic3.gov
- Use for: Ransomware, data breaches, BEC, cyber crimes

**Local FBI Field Office:**
- Office: [NEAREST FBI OFFICE]
- Phone: [PHONE]
- Contact: [CYBER CRIMES UNIT]

**Secret Service (for financial crimes):**
- Office: [NEAREST OFFICE]
- Phone: [PHONE]

**Local Police Department:**
- Department: [LOCAL PD]
- Cybercrime Unit: [CONTACT]
- Phone: [PHONE]

**State Agencies:**
- Attorney General: [CONTACT]
- State Police: [CONTACT]

---

### Cybersecurity Resources

**Malware Analysis:**
- VirusTotal: https://www.virustotal.com
- Hybrid Analysis: https://www.hybrid-analysis.com
- Any.Run: https://any.run

**Ransomware Resources:**
- ID Ransomware: https://id-ransomware.malwarehunterteam.com
- No More Ransom: https://www.nomoreransom.org

**Threat Intelligence:**
- US-CERT: https://www.cisa.gov/uscert
- SANS ISC: https://isc.sans.edu
- Krebs on Security: https://krebsonsecurity.com

**Breach Notification Guides:**
- IAPP Data Breach Tool: https://iapp.org/resources/article/data-breach-guide/
- State Breach Laws: https://www.ncsl.org/technology-and-communication/security-breach-notification-laws

---

## 8. Post-Incident Activities

### Incident Documentation

**Incident Report Contents:**
1. **Executive Summary**
   - What happened (brief)
   - Business impact
   - Response actions taken
   - Current status
   - Recommendations

2. **Incident Timeline**
   - Initial compromise (estimated)
   - Detection
   - Key response milestones
   - Resolution

3. **Technical Details**
   - Attack vector
   - Systems affected
   - Data involved
   - Indicators of compromise (IOCs)

4. **Response Actions**
   - Containment steps
   - Eradication steps
   - Recovery steps
   - Communication actions

5. **Impact Assessment**
   - Business impact (downtime, revenue loss)
   - Data impact (records affected)
   - Financial impact (response costs, fines, etc.)
   - Reputational impact

6. **Root Cause Analysis**
   - How did this happen?
   - What controls failed or were missing?
   - Contributing factors

7. **Lessons Learned**
   - What worked well
   - What didn't work
   - Gaps identified

8. **Recommendations**
   - Technical improvements
   - Process improvements
   - Training needs
   - Resource needs

**Report Distribution:**
- Incident response team
- Executive team
- Board of directors (executive summary)
- Audit/compliance team
- Regulators (if required)
- Insurance carrier

---

### Continuous Improvement

**Post-Incident Review Meeting:**
- Schedule within 2 weeks of incident closure
- Include all response team members
- Facilitated discussion (no blame)
- Document lessons learned

**Action Items:**
- [ ] Assign owner for each action item
- [ ] Set realistic deadlines
- [ ] Track in project management system
- [ ] Report on status monthly
- [ ] Verify completion

**Plan Updates:**
- [ ] Update incident response plan based on lessons learned
- [ ] Update runbooks/procedures
- [ ] Update contact lists
- [ ] Update communication templates
- [ ] Re-train team on changes

**Training and Awareness:**
- [ ] Share lessons learned (anonymized) with organization
- [ ] Conduct tabletop exercises for similar scenarios
- [ ] Update security awareness training content
- [ ] Cross-train team members

---

## 9. Appendices

### Appendix A: Incident Response Checklist

**DETECTION:**
- [ ] Alert/incident reported
- [ ] Incident ticket created
- [ ] Initial assessment completed
- [ ] Severity assigned

**TRIAGE:**
- [ ] Incident validated (not false positive)
- [ ] Incident response team activated
- [ ] Incident commander assigned
- [ ] Command center established
- [ ] Incident log started
- [ ] Scope assessment initiated

**CONTAINMENT:**
- [ ] Affected systems identified
- [ ] Systems isolated
- [ ] Compromised accounts disabled
- [ ] Attacker access blocked
- [ ] Evidence preserved
- [ ] Stakeholders notified

**ERADICATION:**
- [ ] Root cause identified
- [ ] Malware/backdoors removed
- [ ] Vulnerabilities patched
- [ ] Credentials reset
- [ ] Verification complete

**RECOVERY:**
- [ ] Systems restored/rebuilt
- [ ] Testing completed
- [ ] Services restored
- [ ] Enhanced monitoring active
- [ ] Business sign-off obtained

**POST-INCIDENT:**
- [ ] Incident report completed
- [ ] Lessons learned meeting held
- [ ] Action items assigned and tracked
- [ ] Plan/procedures updated
- [ ] Training conducted

---

### Appendix B: Evidence Collection Guidelines

**General Principles:**
- Document everything
- Maintain chain of custody
- Take photographs
- Minimize changes to evidence
- Use forensically sound methods

**What to Collect:**
- System memory (RAM dump)
- Hard drive images
- Log files (system, application, network)
- Network traffic captures
- Email messages
- Screenshots
- Physical evidence (USB drives, notes)

**Chain of Custody:**
- Who collected evidence
- Date and time
- Location
- Methods used
- Who has handled evidence
- Where stored

---

### Appendix C: Decision Trees

**Ransomware Decision Tree:**
```
Ransomware Detected
      ↓
Can restore from backups?
      ├─ YES → Restore from backups (DO NOT PAY)
      └─ NO → ↓
                ↓
Is business impact critical?
(Lives at risk, business failure)
      ├─ NO → Do not pay, rebuild
      └─ YES → ↓
                ↓
Is payment legal? (Check OFAC)
      ├─ NO → Do not pay
      └─ YES → ↓
                ↓
Executive decision required
      ↓
[CEO + Board + Legal Counsel]
      ↓
Consider payment (LAST RESORT)
```

---

### Appendix D: Communication Templates

See Section 6 for full templates.

---

### Appendix E: Testing and Maintenance

**Annual Testing Requirements:**
- [ ] Tabletop exercise (1x per year minimum)
- [ ] Technical drill (1x per year)
- [ ] Communication drill (1x per year)

**Quarterly Reviews:**
- [ ] Update contact lists
- [ ] Review retainer agreements
- [ ] Verify backup restoration
- [ ] Review lessons learned action items

**Plan Review:**
- [ ] Annual comprehensive review
- [ ] Update after major incidents
- [ ] Update for regulatory changes
- [ ] Update for organizational changes

---

### Appendix F: Glossary

**APT**: Advanced Persistent Threat
**BEC**: Business Email Compromise
**DDoS**: Distributed Denial of Service
**EDR**: Endpoint Detection and Response
**IOC**: Indicator of Compromise
**IPS/IDS**: Intrusion Prevention/Detection System
**MSSP**: Managed Security Service Provider
**PII**: Personally Identifiable Information
**PHI**: Protected Health Information
**RTO**: Recovery Time Objective
**RPO**: Recovery Point Objective
**SIEM**: Security Information and Event Management
**SOC**: Security Operations Center
**TTPs**: Tactics, Techniques, and Procedures

---

## Document Control

### Review and Approval

| Role | Name | Signature | Date |
|------|------|-----------|------|
| CISO/Author | | | |
| Legal Counsel | | | |
| CIO | | | |
| CEO | | | |

### Version History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | [DATE] | [NAME] | Initial version |
| | | | |

### Distribution List
- Executive team
- Incident response team
- IT management
- Legal counsel
- HR leadership
- Audit/compliance team

**Document Classification**: CONFIDENTIAL - Internal Use Only

---

**END OF INCIDENT RESPONSE PLAN**
