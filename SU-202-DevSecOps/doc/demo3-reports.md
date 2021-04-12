# Demo 3 - Reports

## Context

- You want to collect security status of your production grade repository

## Objective

- Show benefits of using Reports

## Vulnerability Report

### General scope
- name: devsecops-prod-swampup
- Scope: repository devsecops-docker-prod-local
- impacted artifact: */swampup/devsecops:*

=> this is a lot of information, maybe we can narrow down a bit the list of vulnerabilities

### Refine on severity
- name: devsecops-prod-swampup-high
- Scope: repository devsecops-docker-prod-local
- impacted artifact: */swampup/devsecops:*
- severity: high

=> let's make this actionable

### Refine on severity
- name: devsecops-prod-swampup-high-with-fix
- Scope: repository devsecops-docker-prod-local
- impacted artifact: */swampup/devsecops:*
- severity: high
- Remediation: Has Fix

=> We can transmit this information to the Dev team, 
or even better have the Dev team to auto generate this report, once per sprint for instance

### Export

export previous report to PDF
=> check vulnerable component = always the same
=> check highest Fix Version = 2.5.26

=> we'll be able to take advantage of this information later on

## Due Diligence Report

in some cases, when distributing a mobile app for instance, 
you may need to expose licenses of your open source dependencies.

### Create report
- name: devsecops-prod-swampup-licenses
- Scope: repository devsecops-docker-prod-local
- artifact: */swampup/devsecops:0.0.9
- Known Licenses

=> unrecognized license = license found in the dependency but not known by Xray 

### Export

export previous report to PDF

## Violation reports

=> helpful to combine vulnerabilities and license issues.
=> allow collecting Ignored violations as well

## Conclusion

Reports help to have a clear and shareable information in regards with your security and license compliance policies.