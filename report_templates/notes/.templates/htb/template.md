---
layout: post
title: "_title_"
date: _date_
# List Format
table_of_contents:
    - Overview
    - Enumeration
    - Initial Foothold
    - Privilege Escalation
    - Remediation
initial_creds: "_creds_"
# List Format
ip_addresses: 
    - 10.10.11.68
---


# {{ page.title }}

## Table of Contents
{% for content in page.table_of_contents %}
 - <a href="#{{ content | downcase | replace: ' ', '-' }}">{{ content  }}</a> 
 {% endfor %}



## {{ page.table_of_contents[0] }} <a name="{{ page.table_of_contents[0] | downcase | replace: ' ', '-' }}"></a>
**Scope**
{% if page.ip_addresses %}
IP Addresses:
{% for ip in page.ip_addresses %}
- {{ ip }}
{% endfor %}
{% endif %}
{%if page.initial_creds %}
Initial Credentials:
- {{ page.initial_creds }}
{% endif %}


## {{ page.table_of_contents[1] }} <a name="{{ page.table_of_contents[0] | downcase | replace: ' ', '-' }}"></a>


## {{ page.table_of_contents[2] }} <a name="{{ page.table_of_contents[0] | downcase | replace: ' ', '-' }}"></a>


## {{ page.table_of_contents[3] }} <a name="{{ page.table_of_contents[3] | downcase | replace: ' ', '-' }}"></a>


## {{ page.table_of_contents[4] }} <a name="{{ page.table_of_contents[4] | downcase | replace: ' ', '-' }}"></a>

