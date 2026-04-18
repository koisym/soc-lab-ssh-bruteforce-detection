# SSH Brute Force Detection Lab (Splunk)

## Overview

I created this project to build hands-on experience with security monitoring and incident detection in a SOC-style lab environment. The objective was to simulate an SSH brute-force attack, ingest Linux authentication logs into Splunk, and create a detection that could identify repeated failed login attempts from the same source.

This project gave me practical experience working with logs, building detections, and understanding how suspicious authentication activity can be identified in a SIEM.

---

## Lab Environment

The lab was built in VirtualBox using the following systems:

- Kali Linux (attacker)
- Ubuntu Server (target)
- Splunk Enterprise / Free (SIEM)

Both virtual machines were connected on the same virtual network to allow realistic traffic between systems.

---

## Project Steps

### 1. Configured SSH on the Target System
I installed and enabled the OpenSSH service on the Ubuntu server so it could receive remote login attempts.

### 2. Simulated Brute-Force Activity
Using Kali Linux, I generated multiple failed SSH login attempts against the Ubuntu server. This created authentication events inside `/var/log/auth.log`.

### 3. Collected Logs in Splunk
I configured Splunk to monitor the authentication log so failed login activity could be searched and analyzed.

### 4. Built a Detection Query
I created a search that extracted source IP addresses from failed login events and counted repeated attempts.

### 5. Created an Alert
The detection was saved as an alert to simulate how a SOC team would be notified of suspicious login behavior.

---

## Detection Query

```spl
index=* "Failed password"
| rex field=_raw "from (?<src_ip>\d+\.\d+\.\d+\.\d+)"
| stats count by src_ip
| where count > 3
