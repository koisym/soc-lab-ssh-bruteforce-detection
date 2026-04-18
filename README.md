# SSH Brute Force Detection Lab (Splunk)

## Overview

I built this home lab project to practice detecting SSH brute-force attacks in a SIEM environment. The goal was to simulate repeated failed login attempts, collect the Linux authentication logs, and create detection logic in Splunk that could identify suspicious activity.

This project helped me get hands-on experience with log analysis, basic detection engineering, and alert creation.

---

## Lab Environment

I used the following setup:

- VirtualBox
- Kali Linux (attacker machine)
- Ubuntu Server (target machine)
- Splunk Enterprise / Free

The VMs were placed on the same virtual network so they could communicate with each other.

---

## What I Did

### 1. Configured the Target System
I installed and enabled SSH on the Ubuntu server so it could accept remote login attempts.

### 2. Simulated Failed Login Attempts
From Kali Linux, I generated multiple failed SSH login attempts to create realistic authentication events in `/var/log/auth.log`.

### 3. Ingested Logs into Splunk
I configured Splunk to monitor the Ubuntu authentication log so the events would be searchable.

### 4. Built Detection Logic
I created a search that counted repeated failed login attempts by source IP address.

---

## Detection Query

```spl
index=* "Failed password"
| rex field=_raw "from (?<src_ip>\d+\.\d+\.\d+\.\d+)"
| stats count by src_ip
| where count > 3
