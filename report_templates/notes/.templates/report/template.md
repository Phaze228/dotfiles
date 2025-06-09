---
layout: post
title: "Penetration Test"
subtitle: "CPTS Exam Report"
author:
    name: Alexander Chin-Lenn
    affiliation: HTB Candidate
    email: alex@chin-tech.org
# date: 
random_variable: "hello yo bro"
# List Format
company_logo: ""
company: Inlanefreight
toc: true
company_name: Inlanefreight
company_contacts:
    name: John Doe
    affiliation: CEO
    email: jDoe@inlanefreight.htb
customer_name: InlaneFreight
initial_creds: "_creds_"
# List Format
ip_addresses: 
    - 10.10.11.69
    - 10.10.11.70
    - 10.10.11.71
    - 10.10.11.72
    - 10.10.11.73
---


# Statement of Confidentiality

The contents of this document have been developed by the Author of this paper. The Author considers this document to be proprietary and business confidential information. This information is to be used only in the performance of its intended use . This document may not be released to another vendor, business partner or contractor without prior written consent from the Author. Additionally, no portion of this document may be communicated, reproduced, copied, or distributed with prior consent of the Author.

The contents of this document do not consistute legal advice. The Author's offer of services that relate to compliance, litigation, or other legal interestes are not intended as legal counsel and should not be taken as such. The assessment detailed herin is against a fictional company for training and examination purposes, and the vulnerabilities in no way affect Hack The Box's external or internal infrastructure.

# Engagement Contacts

%company_contacts%


%assesor_contacts%



# Overview

This is a %report_type% document for %company_name%. It was conducted by the assesors referenced in the engagement contacts.


# Executive Summary

%company_name% ("%company_shortname%" herein) contracted %author% ("Assessor" herein) to perform a penetration test of %company_shortname%'s  externally facing network to identify unknown weaknesses, vulnerabilities, and misconfiguations. Testing was performed non-evasively, meaning no attempt was made to subvert detection from blue-team efforts. Testing was performed remotely from %authors% assessment labs. Each finding was documented and investigated to determine the exploitation and/or escalation potential. Assessor sought to demonstrate the full impact of every vulnerability, up to and including internal domain compromise. If the Assessor gained a foothold in the internal network, %company_shortname% allowed for further testing including lateral movement and horizontal/vertical privilege escalation to demonstrate the business impact of an internal network compromise.

## Approach

%approach_type%

## Scope

## Assesment Overview

# Network Penetration Test Assessment Summary

## Detailed Walkthrough

# Internal Network Compromise

## Detailed walkthough

# Remediation Summary

## Quick Fixes

## Medium-Term 

## Long-Term 

# Detailed Technical Findings

<!-- For the author: Start a line with CVSS X.X to provide the proper syntax highlighting for the document -->
This section contains detailed technical findings of the assessment ordered by [Common Vulnerability Scoring System (CVSS) Rating](https://www.first.org/cvss/). The CVSS rating is a measure of how _severe_ a vulnerability is or _could be_. It is not indicative of the risk that these vulnerabilties may have to your organization. Meaning, we can have a a vulnerability that has a critical rating of 9.8 because it is exploitable over the internet and doesn't need authentication. However, that could be an isolated system without exposure to any customer facing data. To mitigate this confusion, there will be notes included to draw your attention to particular findings.

Below will be all of the findings by the finding, the CVSS Score, a high-level definition of the vulnerability for reference, and the specific example found during the assessment.

### SQL Injection 

CVSS 7.1 blah

SQL Injection
: A method of providing input to database that allows for remote code execution

### Insecure Passwords


CVSS 3.0  this is not so bad

CVSS 6.0  Okay probably bad

CVSS 9.5 Holy shit, fix this

# Appendix

##  Severities

## Host & Service Discovery

## Subdomain Discovery

## Exploited Hosts

## Compromised Users

## Alterations / Host Cleanup

## Flags 

## Tools Reference

This will provide links for any non-proprietary tools used, proprietary ones will be named if used. 

[nmap - Network Mapper](https://nmap.org/) : Used for network scans
[nxc - NetExec](https://www.netexec.wiki/) : Network service exploitation tool for a variety of protocols
[Impacket](https://github.com/fortra/impacket/tree/master) : Collection of useful python scripts to interact with and extract data from network protocols
[Bloodhound CE](https://bloodhound.specterops.io/get-started/introduction) : Active directory enumeration tool
[Burpsuite CE](https://portswigger.net/burp/communitydownload) : Useed for intercepting and modifying HTTP requests and responses



