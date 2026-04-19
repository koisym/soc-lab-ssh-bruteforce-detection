# SSH Brute Force Detection Lab

## Overview

This project was my first attempt at building a small SOC-style home lab focused on detection and log analysis. The goal was to simulate an SSH brute-force attack, collect the authentication logs from a Linux system, and use Splunk to identify repeated failed login attempts.

I built this project to get more hands-on practice with security monitoring, basic detection engineering, and understanding how suspicious login activity appears in real log data.

---

## Objective

The objective of this lab was to detect repeated failed SSH login attempts from the same source IP address and turn that activity into a simple alert inside Splunk.

---

## Lab Environment

I built the lab in VirtualBox using the following systems:

- Kali Linux as the attacker machine
- Ubuntu Server as the target system
- Splunk Enterprise / Free as the SIEM

Both virtual machines were placed on the same virtual network so they could communicate with each other during testing.

---

## What I Did

### 1. Set up the lab
I created two virtual machines in VirtualBox. One was used as the attacking system and the other was used as the target. I confirmed the systems could communicate over the same virtual network before moving forward.

### 2. Enabled SSH on Ubuntu
I installed and enabled the OpenSSH service on the Ubuntu machine so that it could accept remote login attempts.

### 3. Generated failed login activity
From the Kali machine, I generated multiple failed SSH login attempts against the Ubuntu server. This created authentication events in `/var/log/auth.log`.

### 4. Ingested logs into Splunk
I configured Splunk to monitor the authentication log on the Ubuntu system so I could search and analyze the events.

### 5. Built a detection query
I wrote a Splunk search to find failed password events, extract the source IP address, and count repeated attempts from the same system.

### 6. Created an alert
After confirming the query worked, I saved it as an alert to simulate a basic SOC detection workflow.

---

## Detection Query

```spl
index=* "Failed password"
| rex field=_raw "from (?<src_ip>\d+\.\d+\.\d+\.\d+)"
| stats count by src_ip
| where count > 3
```

## Results

The query successfully identified repeated failed SSH login attempts from the attacking system. I was able to extract the source IP address, count the number of failed attempts, and confirm the activity was visible in the logs.

This lab helped me understand how brute-force behavior appears in Linux authentication logs and how a SIEM can be used to detect that activity.

---

## Skills Demonstrated

- Security monitoring
- Splunk SPL
- Linux log analysis
- Authentication event investigation
- Basic detection logic
- Alert creation
- Virtual lab setup
- Troubleshooting connectivity and logging issues

---

## Challenges I Ran Into

Since this was my first time building a lab like this, I ran into a few setup issues along the way. The biggest challenges were networking between the virtual machines, getting Splunk installed correctly, and making sure the authentication logs were being ingested. Solving those problems was a valuable part of the learning process.

---

## Key Takeaways

One of the biggest lessons from this project was how important log visibility is during an investigation. Even a simple attack can leave a clear trail when the right logs are collected and reviewed.

I also learned that building a detection is not just about writing a query. You also need to validate the environment, confirm the logs are arriving, and tune the search so it returns useful results instead of noise.

Because this was my first project of this kind, it gave me a much better understanding of how log collection, investigation, and alerting fit together in a SOC workflow.

---

## Future Improvements

In a future version of this lab, I would like to:

- Compare successful and failed SSH login activity
- Create a dashboard to visualize failed login trends
- Tune the detection threshold further
- Add trusted IP addresses to reduce noise
- Expand the lab to cover other remote access attacks

---

## Screenshots

The screenshots folder includes examples of:

- Failed SSH login attempts from Kali <img width="644" height="512" alt="kali-attack" src="https://github.com/user-attachments/assets/ccb5a99c-aabb-413a-8354-1c23b9f62fb0" />
- Splunk search results for failed password events <img width="1213" height="766" alt="splunk-search-results" src="https://github.com/user-attachments/assets/b2664373-672c-43b3-9586-0a231915d38d" />
- Alert configuration<img width="802" height="577" alt="splunk-alert" src="https://github.com/user-attachments/assets/7e4eea6c-dba0-411a-840d-68386d18a776" />
- Dashboard or investigation views<img width="1210" height="767" alt="splunk-dashboard" src="https://github.com/user-attachments/assets/244c4d4c-22ac-4875-a8d1-91e02a8f79bc" />

---

## Project Status

Completed as an entry-level SOC lab project and documented as part of my cybersecurity portfolio.
