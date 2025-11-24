# Security Assessment Checklist
## Consultant's Field Guide

This checklist provides a structured approach for consultants conducting security assessments. Use this during client engagements to ensure comprehensive coverage.

---

## Assessment Preparation

### Pre-Assessment Activities
- [ ] Define assessment scope and objectives
- [ ] Identify key stakeholders (CISO, CIO, CFO, Legal)
- [ ] Schedule interviews (executives, IT staff, end users)
- [ ] Request documentation in advance
- [ ] Execute NDA and assessment agreements
- [ ] Identify assessment team roles

### Required Documentation to Request
- [ ] Network diagrams
- [ ] System inventory
- [ ] Security policies
- [ ] Recent audit reports
- [ ] Incident logs (past 12 months)
- [ ] Disaster recovery plans
- [ ] Vendor contracts and SLAs
- [ ] Insurance policies (cyber insurance)
- [ ] Org charts (IT and Security teams)
- [ ] Compliance documentation

---

## 1. Governance and Risk Management

### Leadership and Organization
- [ ] Does organization have a dedicated CISO?
- [ ] Where does CISO report? (CEO/CRO preferred, not CIO)
- [ ] Is there a security steering committee?
- [ ] Does board receive regular security briefings?
- [ ] Are security roles and responsibilities defined?
- [ ] Is there adequate security staffing?

**Evidence to Review:**
- Organization charts
- Job descriptions
- Board meeting minutes
- Steering committee charter

**Red Flags:**
- No dedicated security leader
- CISO reports to CIO (conflict of interest)
- Security responsibilities unclear
- No board-level oversight

---

### Policies and Procedures
- [ ] Does master information security policy exist?
- [ ] Are policies reviewed annually?
- [ ] Do policies cover all critical areas? (See list below)
- [ ] Are policies communicated to employees?
- [ ] Is policy compliance monitored?
- [ ] Are policy violations enforced?

**Required Policy Areas:**
- [ ] Acceptable Use Policy
- [ ] Access Control Policy
- [ ] Data Classification
- [ ] Incident Response
- [ ] Business Continuity
- [ ] Third-Party Risk Management
- [ ] Remote Access
- [ ] Encryption
- [ ] Security Awareness Training

**Evidence to Review:**
- Policy documents
- Policy acknowledgment records
- Policy violation reports
- Last review dates

**Scoring:**
- All policies current and comprehensive: 5 points
- Policies exist but outdated: 3 points
- Incomplete policy coverage: 2 points
- No formal policies: 1 point

---

### Risk Management
- [ ] Is there a formal risk assessment process?
- [ ] Are risks documented in a risk register?
- [ ] Are risks reviewed regularly (quarterly minimum)?
- [ ] Is there a risk acceptance process?
- [ ] Are residual risks quantified?
- [ ] Is cyber insurance in place?

**Questions to Ask:**
- What are your top 5 cyber risks?
- How do you prioritize security investments?
- What risk appetite has board defined?
- What's your cyber insurance coverage limit?

**Evidence to Review:**
- Risk register
- Risk assessments
- Board risk reports
- Insurance policies

**Red Flags:**
- No documented risks
- Last risk assessment >1 year old
- No risk acceptance process
- Uninsured or underinsured

---

## 2. Asset and Data Management

### Asset Inventory
- [ ] Complete inventory of hardware assets?
- [ ] Complete inventory of software/applications?
- [ ] Are cloud resources inventoried?
- [ ] Are assets classified by criticality?
- [ ] Are asset owners identified?
- [ ] Is inventory kept current (automated)?

**Questions to Ask:**
- How many servers, workstations, mobile devices do you have?
- Are shadow IT assets identified?
- How do you track asset changes?
- Do you have an asset management tool?

**Evidence to Review:**
- Asset inventory database/spreadsheet
- Configuration management database (CMDB)
- Cloud resource inventory
- License management

**Scoring:**
- Complete, automated, current: 5 points
- Mostly complete, some manual: 3 points
- Incomplete or outdated: 2 points
- No inventory: 1 point

---

### Data Classification and Handling
- [ ] Is data classified (Public, Internal, Confidential, Restricted)?
- [ ] Is sensitive data identified and mapped?
- [ ] Are data owners assigned?
- [ ] Is data retention policy defined?
- [ ] Are data handling procedures documented?
- [ ] Is data disposal process secure?

**Questions to Ask:**
- What sensitive data do you collect/store?
- Where is customer data located?
- How long do you retain data?
- How do you dispose of data securely?

**Evidence to Review:**
- Data classification policy
- Data inventory/map
- Data retention schedules
- Disposal procedures

**Red Flags:**
- No data classification scheme
- Unknown data locations
- No documented data owners
- Ad-hoc data disposal

---

## 3. Access Control and Identity Management

### User Access Management
- [ ] Is least privilege principle enforced?
- [ ] Are access requests formally documented?
- [ ] Are access approvals required?
- [ ] Are access reviews conducted regularly?
- [ ] Is access revocation timely (same day for terminations)?
- [ ] Are shared accounts eliminated/minimized?

**Questions to Ask:**
- How do employees request access?
- Who approves access requests?
- When was last access review?
- How quickly is access removed for terminated employees?

**Test Scenarios:**
- Sample recent terminations - was access removed?
- Review access logs for unusual patterns
- Check for accounts with excessive privileges

**Evidence to Review:**
- Access request tickets
- Access review reports
- Termination checklist
- Account listing with privileges

**Scoring:**
- Formal process, quarterly reviews, same-day revocation: 5 points
- Process exists, annual reviews, 1-day revocation: 3 points
- Informal process, infrequent reviews: 2 points
- No formal process: 1 point

---

### Authentication
- [ ] Is multi-factor authentication (MFA) required for VPN?
- [ ] Is MFA required for cloud applications?
- [ ] Is MFA required for privileged accounts?
- [ ] Is MFA required for email (O365, Gmail)?
- [ ] Are password requirements strong? (12+ chars, complexity)
- [ ] Is single sign-on (SSO) implemented?

**Questions to Ask:**
- What percentage of users have MFA enabled?
- What MFA methods are used? (Push, SMS, Hardware token)
- How often do passwords expire?
- Are previous passwords remembered (prevent reuse)?

**Evidence to Review:**
- MFA enrollment reports
- Password policy configuration
- Authentication logs
- SSO implementation

**Critical Priority:**
- MFA on all external access is HIGHEST priority
- SMS MFA is weak - push notifications or hardware tokens preferred
- Password requirements matter less if MFA is enforced

**Scoring:**
- MFA everywhere, strong passwords, SSO: 5 points
- MFA on VPN and privileged accounts: 3 points
- MFA optional or limited: 2 points
- No MFA: 1 point (CRITICAL)

---

### Privileged Access Management
- [ ] Are administrative accounts separate from user accounts?
- [ ] Is privileged access monitored/logged?
- [ ] Are privileged sessions recorded?
- [ ] Is just-in-time access used?
- [ ] Are service accounts managed?
- [ ] Is privileged account password rotation automated?

**Questions to Ask:**
- Do admins use separate accounts for admin tasks?
- How are admin passwords managed?
- Can you audit what admins are doing?
- How many accounts have domain admin rights?

**Evidence to Review:**
- Privileged account inventory
- Admin activity logs
- PAM tool configuration (if any)
- Password vault

**Red Flags:**
- Admins use same account for email and admin tasks
- Many accounts with domain admin
- No logging of admin activity
- Shared admin passwords

---

## 4. Network Security

### Network Architecture
- [ ] Is network segmented by function/security level?
- [ ] Are firewalls deployed between segments?
- [ ] Is DMZ used for internet-facing systems?
- [ ] Are guest networks isolated from corporate?
- [ ] Is wireless encrypted (WPA3 or WPA2-Enterprise)?
- [ ] Are insecure protocols disabled? (Telnet, FTP, HTTP)

**Questions to Ask:**
- Describe your network architecture
- Can workstations talk directly to servers?
- How is internet access controlled?
- Are production and development networks separated?

**Evidence to Review:**
- Network diagrams
- Firewall rulesets
- VLAN configurations
- Wireless configurations

**Scoring:**
- Micro-segmentation, zero-trust: 5 points
- Basic segmentation (servers, workstations, guest): 3 points
- Flat network with firewall at perimeter: 2 points
- Completely flat network: 1 point (CRITICAL)

---

### Perimeter Security
- [ ] Are firewalls at network perimeter?
- [ ] Are firewall rules reviewed regularly?
- [ ] Is intrusion detection/prevention (IDS/IPS) deployed?
- [ ] Is web application firewall (WAF) used for web apps?
- [ ] Is DDoS protection in place?
- [ ] Are unused ports/services closed?

**Questions to Ask:**
- When were firewall rules last reviewed?
- How do you handle rule requests?
- Do you have IDS/IPS? Who monitors alerts?
- How do you protect against DDoS?

**Evidence to Review:**
- Firewall configurations
- IDS/IPS reports
- WAF logs
- Port scan results

**Test Activity:**
- External port scan (with permission)
- Review for unnecessary open ports

---

### Remote Access
- [ ] Is VPN required for remote access?
- [ ] Is VPN split-tunneling disabled?
- [ ] Is remote desktop (RDP) secured? (Not exposed to internet)
- [ ] Are remote access sessions logged?
- [ ] Is remote access limited to specific users?
- [ ] Is remote access from untrusted devices controlled?

**Questions to Ask:**
- How do employees access systems remotely?
- Is RDP accessible from the internet?
- Do you allow personal devices?
- How is remote access monitored?

**Evidence to Review:**
- VPN configuration
- Remote access logs
- RDP exposure check
- Remote access policy

**Critical Check:**
- RDP exposed to internet is CRITICAL vulnerability
- Scan Shodan.io for your IP ranges

---

## 5. Endpoint Security

### Endpoint Protection
- [ ] Is antivirus/EDR installed on all endpoints?
- [ ] Are endpoint agents up-to-date?
- [ ] Is real-time scanning enabled?
- [ ] Are USB devices controlled?
- [ ] Is full disk encryption enabled?
- [ ] Are endpoints centrally managed?

**Questions to Ask:**
- What endpoint protection do you use? (AV vs EDR)
- What percentage of endpoints are protected?
- Who monitors endpoint alerts?
- Are personal devices allowed? How are they secured?

**Evidence to Review:**
- Endpoint protection console
- Agent deployment status
- Alert/detection reports
- USB device policy

**Scoring:**
- EDR with 24/7 monitoring, full coverage: 5 points
- EDR with business hours monitoring: 3 points
- Antivirus only: 2 points
- No/limited protection: 1 point (CRITICAL)

---

### Patch Management
- [ ] Is there a formal patch management process?
- [ ] Are critical patches applied within 14 days?
- [ ] Are systems scanned for missing patches?
- [ ] Are end-of-life systems identified?
- [ ] Is patching automated where possible?
- [ ] Are patch failures tracked and resolved?

**Questions to Ask:**
- How quickly do you patch critical vulnerabilities?
- What's your current patch compliance rate?
- Do you have any Windows Server 2008 or other EOL systems?
- How do you handle systems that can't be patched?

**Evidence to Review:**
- Patch management reports
- Vulnerability scan results
- System inventory (version levels)
- EOL system list

**Test Activity:**
- Review recent critical CVEs
- Check if patches applied timely

**Critical Priority:**
- Unpatched internet-facing systems: CRITICAL
- End-of-life systems: HIGH risk

---

### Mobile Device Management
- [ ] Are mobile devices enrolled in MDM?
- [ ] Are devices encrypted?
- [ ] Are devices password/PIN protected?
- [ ] Can devices be remotely wiped?
- [ ] Are corporate and personal data separated?
- [ ] Are mobile apps managed?

**Questions to Ask:**
- How many mobile devices access corporate data?
- Do you support BYOD (bring your own device)?
- Can you remotely wipe lost devices?
- How is mobile email secured?

**Evidence to Review:**
- MDM enrollment status
- Mobile device policy
- Lost/stolen device procedures

---

## 6. Application Security

### Application Inventory and Management
- [ ] Is there an inventory of all applications?
- [ ] Are application owners identified?
- [ ] Are applications classified by criticality?
- [ ] Are unsupported/EOL applications identified?
- [ ] Is shadow IT identified and managed?
- [ ] Are cloud applications tracked?

**Questions to Ask:**
- How many applications does the organization use?
- What's your process for approving new applications?
- Do you know what cloud services employees use?
- How many custom-developed applications do you have?

---

### Secure Development (for custom apps)
- [ ] Is security included in SDLC?
- [ ] Are developers trained on secure coding?
- [ ] Is code reviewed before production?
- [ ] Are applications tested for vulnerabilities?
- [ ] Are third-party libraries tracked for vulnerabilities?
- [ ] Is static/dynamic code analysis performed?

**Questions to Ask:**
- How do you ensure applications are secure?
- Do you perform penetration testing?
- How do you manage third-party code dependencies?

**Evidence to Review:**
- SDLC documentation
- Security testing reports
- Pen test results
- Code review records

---

### Web Application Security
- [ ] Are web applications behind WAF?
- [ ] Are web apps scanned for vulnerabilities?
- [ ] Is input validation implemented?
- [ ] Are APIs secured?
- [ ] Is HTTPS enforced?
- [ ] Are security headers configured?

**Test Activity:**
- Review OWASP Top 10 vulnerabilities
- Check for SQL injection, XSS
- Review API security

---

## 7. Data Protection

### Encryption
- [ ] Is data encrypted at rest (databases, file servers)?
- [ ] Is data encrypted in transit (TLS 1.2+)?
- [ ] Are backups encrypted?
- [ ] Are mobile devices/laptops encrypted?
- [ ] Is email encryption available for sensitive data?
- [ ] Is encryption key management documented?

**Questions to Ask:**
- Where is sensitive data stored, and is it encrypted?
- How are encryption keys managed?
- Is data encrypted during transmission?
- What happens if a laptop is lost?

**Evidence to Review:**
- Encryption policy
- Database encryption status
- TLS/SSL certificates
- Key management procedures

**Scoring:**
- Comprehensive encryption, documented key management: 5 points
- Encryption for most sensitive data: 3 points
- Limited encryption: 2 points
- No encryption: 1 point (CRITICAL)

---

### Data Loss Prevention (DLP)
- [ ] Is DLP deployed on endpoints?
- [ ] Is DLP deployed on email gateway?
- [ ] Is DLP deployed for cloud applications?
- [ ] Are DLP policies configured for sensitive data types?
- [ ] Are DLP alerts monitored?
- [ ] Are USB devices controlled?

**Questions to Ask:**
- How do you prevent sensitive data from leaving the organization?
- Can employees email customer data to personal accounts?
- Are USB drives allowed?
- Do you monitor data exfiltration attempts?

**Evidence to Review:**
- DLP tool configuration
- DLP incident reports
- USB device policy
- Email filtering rules

---

### Backup and Recovery
- [ ] Are backups automated and scheduled?
- [ ] Are backups stored offsite/off-network?
- [ ] Are backups encrypted?
- [ ] Are backups tested regularly (monthly minimum)?
- [ ] Is backup retention appropriate (90+ days)?
- [ ] Are backups immutable (cannot be deleted by attackers)?

**Questions to Ask:**
- When was the last backup restoration test?
- How quickly can you restore critical systems?
- Are backups protected from ransomware?
- Who has access to backups?

**Evidence to Review:**
- Backup logs
- Restoration test results
- Backup architecture
- RTO/RPO documented

**Critical Priority:**
- Backups are THE most critical ransomware defense
- Immutable/air-gapped backups are essential
- Test restoration regularly

**Scoring:**
- Immutable backups, monthly tests, documented RTO/RPO: 5 points
- Regular backups, quarterly tests: 3 points
- Backups exist, testing infrequent: 2 points
- No backups or untested: 1 point (CRITICAL)

---

## 8. Security Monitoring and Incident Response

### Security Monitoring
- [ ] Is there centralized log collection (SIEM)?
- [ ] Are critical systems sending logs to SIEM?
- [ ] Are logs retained for adequate period? (90+ days, 1 year for compliance)
- [ ] Are security alerts defined?
- [ ] Is there 24/7 monitoring? (In-house or MSSP)
- [ ] Are alerts triaged and investigated?

**Questions to Ask:**
- What security monitoring tools do you use?
- Who monitors security alerts? 24/7 or business hours?
- How many alerts per day? What's false positive rate?
- How quickly do you detect incidents?

**Evidence to Review:**
- SIEM deployment
- Alert rules
- SOC procedures
- Incident metrics (MTTD, MTTR)

**Scoring:**
- SIEM with 24/7 SOC, comprehensive coverage: 5 points
- SIEM with business hours monitoring: 3 points
- Limited monitoring, no SIEM: 2 points
- No monitoring: 1 point (CRITICAL)

---

### Incident Response
- [ ] Is there a documented incident response plan?
- [ ] Is incident response team identified?
- [ ] Are team members trained on their roles?
- [ ] Is plan tested annually (tabletop exercise)?
- [ ] Are incident response retainers in place? (Legal, forensics, PR)
- [ ] Are incidents logged and tracked?

**Questions to Ask:**
- When was the last security incident?
- When was the last tabletop exercise?
- Who would you call at 2am for a breach?
- Do you have incident response retainers?

**Evidence to Review:**
- Incident response plan
- Tabletop exercise reports
- Incident log
- Retainer agreements

**Test Activity:**
- Conduct tabletop exercise during assessment (if time permits)

**Red Flags:**
- No incident response plan
- Plan never tested
- No external support relationships
- Can't find incident response plan

---

### Vulnerability Management
- [ ] Are vulnerability scans conducted regularly?
- [ ] Are both internal and external scans performed?
- [ ] Are vulnerabilities prioritized and tracked?
- [ ] Are high/critical vulnerabilities remediated timely?
- [ ] Are compensating controls documented for unpatched systems?
- [ ] Is penetration testing conducted annually?

**Questions to Ask:**
- How often do you scan for vulnerabilities?
- What's your average time to remediate critical vulnerabilities?
- When was the last penetration test?
- How many critical/high vulnerabilities are currently open?

**Evidence to Review:**
- Vulnerability scan reports
- Remediation tracking
- Pen test reports
- Compensating control documentation

---

## 9. Third-Party Risk Management

### Vendor Security Assessment
- [ ] Is vendor security assessment required before engagement?
- [ ] Are security requirements in contracts?
- [ ] Are high-risk vendors assessed annually?
- [ ] Are vendors with access to data identified?
- [ ] Are vendor security incidents reported?
- [ ] Is vendor offboarding process secure?

**Questions to Ask:**
- How do you assess vendor security?
- Which vendors have access to your sensitive data?
- Have any vendors had security incidents?
- How do you monitor ongoing vendor risk?

**Evidence to Review:**
- Vendor risk assessments
- Vendor contracts (security clauses)
- Vendor inventory with risk ratings
- Vendor incident reports

---

### Cloud Service Providers
- [ ] Are cloud providers assessed for security?
- [ ] Are cloud configurations audited?
- [ ] Is cloud data encrypted?
- [ ] Is cloud access controlled (IAM)?
- [ ] Are cloud logs collected and monitored?
- [ ] Is multi-cloud environment managed?

**Questions to Ask:**
- What cloud services do you use?
- How do you secure cloud environments?
- Have you had cloud security incidents?
- Who manages cloud security?

---

## 10. Compliance and Legal

### Regulatory Compliance
- [ ] What regulations apply? (GDPR, HIPAA, PCI-DSS, SOX, etc.)
- [ ] Are compliance requirements documented?
- [ ] Are regular compliance assessments conducted?
- [ ] Are audit findings tracked and remediated?
- [ ] Are required certifications maintained?
- [ ] Is compliance training provided?

**Questions to Ask:**
- What regulatory requirements apply to your organization?
- When was the last compliance audit?
- Have you had any regulatory violations or fines?
- How do you track compliance?

**Evidence to Review:**
- Compliance assessments
- Audit reports
- Certifications (ISO 27001, SOC 2, etc.)
- Remediation tracking

---

### Privacy and Data Protection
- [ ] Is privacy policy published?
- [ ] Are data subject rights processes in place? (GDPR)
- [ ] Is data processing inventory maintained?
- [ ] Are data processing agreements (DPA) in place with vendors?
- [ ] Is privacy impact assessment process defined?
- [ ] Is data breach notification process documented?

**Questions to Ask:**
- How do you handle customer data requests (access, deletion)?
- Do you know where all customer data is stored?
- Are data processing agreements in place with vendors?
- How quickly can you notify customers of a breach?

---

### Cyber Insurance
- [ ] Is cyber insurance policy in place?
- [ ] Is coverage amount adequate?
- [ ] What is covered? (Ransomware, breach notification, legal, etc.)
- [ ] Are policy requirements met?
- [ ] Has policy been reviewed recently?
- [ ] Are insurers notified of material changes?

**Questions to Ask:**
- What's your cyber insurance coverage limit?
- Does it cover ransomware payments?
- When was policy last reviewed?
- Have you ever made a claim?

**Evidence to Review:**
- Insurance policy
- Coverage limits
- Policy requirements
- Recent premium changes (indicator of risk)

---

## 11. Security Awareness and Culture

### Training and Awareness
- [ ] Is security awareness training mandatory?
- [ ] Is training provided to new hires?
- [ ] Is refresher training provided annually?
- [ ] Is role-based training provided? (Developers, admins, executives)
- [ ] Is training effectiveness measured?
- [ ] Are employees tested? (Phishing simulations)

**Questions to Ask:**
- What security training do employees receive?
- How often is training provided?
- Do you conduct phishing simulations?
- What's your phishing click rate?

**Evidence to Review:**
- Training completion records
- Training materials
- Phishing simulation results
- Training effectiveness metrics

**Scoring:**
- Mandatory annual training, quarterly phishing tests, <5% click rate: 5 points
- Annual training, semi-annual testing, <15% click rate: 3 points
- Ad-hoc training, testing infrequent: 2 points
- No formal training: 1 point (HIGH risk)

---

### Security Culture
- [ ] Do employees understand security as everyone's responsibility?
- [ ] Is security included in performance reviews?
- [ ] Are security champions identified in business units?
- [ ] Is security discussed in leadership meetings?
- [ ] Are security successes celebrated?
- [ ] Is there a "no blame" culture for reporting incidents?

**Assessment Method:**
- Interview employees at various levels
- Observe security behaviors
- Review internal communications about security

---

## Assessment Scoring Summary

### Scoring Methodology

Calculate scores for each section (1-5 scale):
- **5**: Excellent - Leading practice
- **4**: Good - Above average
- **3**: Satisfactory - Meets minimum requirements
- **2**: Needs Improvement - Gaps present
- **1**: Critical - Significant deficiencies

### Overall Security Posture

| Total Score | Rating | Interpretation |
|-------------|--------|----------------|
| 90-100 | **Excellent** | Mature security program, minor optimization opportunities |
| 75-89 | **Good** | Solid security foundation, some gaps to address |
| 60-74 | **Fair** | Basic security in place, significant improvements needed |
| 45-59 | **At Risk** | Material security gaps, priority action required |
| <45 | **Critical** | Severe deficiencies, immediate action essential |

---

## Report Out

### Executive Summary Format

**Security Posture Overview:**
- Overall score and rating
- Strengths (what's working well)
- Critical findings (must address immediately)
- High-priority findings (address within 3-6 months)
- Medium-priority findings (address within 6-12 months)

**Critical Findings Example:**
1. **No MFA on VPN Access** (Score: 1/5)
   - **Risk**: Compromised credentials can lead to network access
   - **Impact**: HIGH - Potential for full network compromise
   - **Recommendation**: Implement MFA on all VPN access within 30 days
   - **Cost**: $50K-$100K for 500 users
   - **Effort**: 2-3 months

**Roadmap:**
- Quick wins (0-3 months)
- Short-term (3-6 months)
- Medium-term (6-12 months)
- Long-term (12-24 months)

---

## Consultant Tips

**Do:**
✅ Be objective and evidence-based
✅ Provide context for findings (why it matters)
✅ Offer practical, prioritized recommendations
✅ Acknowledge what's working well
✅ Consider organizational constraints (budget, staff, risk appetite)
✅ Provide cost estimates and effort levels

**Don't:**
❌ Be alarmist or use fear tactics
❌ Recommend tools you have conflicts of interest with
❌ Provide one-size-fits-all recommendations
❌ Ignore organizational context
❌ Present findings without remediation guidance
❌ Use excessive technical jargon in executive reports

**Remember:**
- Security is risk management, not perfection
- Perfect security doesn't exist
- Balance security with business enablement
- Build relationships, not just deliver reports
- Follow-up is as important as the assessment
