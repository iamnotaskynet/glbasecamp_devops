### Usefull links

- [presentation](https://docs.google.com/document/d/1RtRfTPX2RwEXz3u3tYdLAPiU5uXqvtcARh_p_oILKDE)

##### Wikipedia
- [Social engineering](https://en.wikipedia.org/wiki/Social_engineering_(security))
- [IDPS](https://en.wikipedia.org/wiki/Intrusion_detection_system)
- [DoS](https://en.wikipedia.org/wiki/Denial-of-service_attack)
- [RDP](https://en.wikipedia.org/wiki/Remote_Desktop_Protocol)
- [DVI](https://en.wikipedia.org/wiki/Desktop_virtualization)
- [XSS](https://en.wikipedia.org/wiki/Cross-site_scripting)
- [CSRF](https://en.wikipedia.org/wiki/Cross-site_request_forgery)
- [SQL injection](https://en.wikipedia.org/wiki/SQL_injection)
- [Phishing](https://en.wikipedia.org/wiki/Phishing)
- [Spamming](https://en.wikipedia.org/wiki/Spamming)
- [MITM](https://en.wikipedia.org/wiki/Man-in-the-middle_attack)
- [BGP](https://en.wikipedia.org/wiki/Border_Gateway_Protocol)
- [Supply chain attack](https://en.wikipedia.org/wiki/Supply_chain_attack)

##### Attacks
- [Cloud Atlas (securelist)](https://securelist.com/recent-cloud-atlas-activity/92016/) (Power Shower, VB Shower)
- [Cloud Hopper (trendmicro)](https://www.trendmicro.com/vinfo/pl/security/news/cyber-attacks/operation-cloud-hopper-what-you-need-to-know)

##### Tools
- [mimikatz](https://github.com/gentilkiwi/mimikatz)
- [LaZagne](https://github.com/AlessandroZ/LaZagne)

##### Backdoors
PlugX, Poison Ivy, ChChes, RedLeaves, Quasar

##### Defense

- [TLS encrypt](https://en.wikipedia.org/wiki/Transport_Layer_Security)
- [Certificates 1](https://en.wikipedia.org/wiki/Certificate_authority), [2](https://en.wikipedia.org/wiki/Public_key_certificate)
- [MAC](https://en.wikipedia.org/wiki/Mandatory_access_control), [RBAC](https://en.wikipedia.org/wiki/Role-based_access_control), [ACL](https://en.wikipedia.org/wiki/Access-control_list)
- logging monitoring auditing 
- secret menager
- [volume encryption](https://en.wikipedia.org/wiki/Disk_encryption)
- Filtering, Quotas, Geo distribution
- Host agregates and availability zones

##### Cloud architecture

- [DDOS protection](https://en.wikipedia.org/wiki/DDoS_mitigation)
- [Firewall](https://en.wikipedia.org/wiki/Firewall_(computing))

- [DMZ](https://en.wikipedia.org/wiki/DMZ_(computing))
- [WAF](https://en.wikipedia.org/wiki/Web_application_firewall)
- [Load balance](https://en.wikipedia.org/wiki/Load_balancing_(computing))
- [Reverse proxy](https://en.wikipedia.org/wiki/Reverse_proxy)

- [Data plane](https://en.wikipedia.org/wiki/Data_plane)
- [Control plane](https://en.wikipedia.org/wiki/Control_plane)
- [Security domain](https://en.wikipedia.org/wiki/Security_domain)

##### [SIEM](https://en.wikipedia.org/wiki/Security_information_and_event_management) + [SOC](https://en.wikipedia.org/wiki/Security_operations_center)

- [Chronicle](https://chronicle.security/)
- [LogRithm](https://logrhythm.com/)
- [Q-Radar IBM](https://www.ibm.com/security/security-intelligence/qradar)
- [Splunk](https://www.splunk.com/)
- [OSSIM](https://cybersecurity.att.com/products/ossim) [wiki](https://en.wikipedia.org/wiki/OSSIM)
- [ArcSight HP](https://www.microfocus.com/en-us/products/security-operations/overview)

##### Homework Task

Do not use your username in password

- Task:
 1. Create and run a script (Ansible playbook) to harden users passwords by rejecting the one that contain a username. Enforce this rule for 'root' as well.
 2. [Optional] Try to implement the same hardening rule without PAM.
 3. Write a report in Google Doc providing the playbook's code and proof of workability (screenshot or asciinema recording).
- Target platform: any Linux-based distribution
- Tools:
 1. Ansible
 2. Utilize PAM authentication module.

##### Homework Run

`ansible-playbook playbook.yml --vault-password-file vault_pass`

##### See also 

- [Free RedHat ansible training](https://www.redhat.com/en/services/training/do007-ansible-essentials-simplicity-automation-technical-overview)
- [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks/)
- [DISA Stigs](https://public.cyber.mil/stigs/)
- [PAM ansible](https://docs.ansible.com/ansible/latest/collections/community/general/pamd_module.html)
- [SUSE](https://documentation.suse.com/sles/12-SP4/html/SLES-all/book-hardening.html)
- [RedHat](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/security_guide/chap-hardening_your_system_with_tools_and_services)
