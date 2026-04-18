# SSH Brute Force Detection Queries

# 1. View all failed SSH logins
index=* "Failed password"

# 2. Show failed attempts by source IP
index=* "Failed password"
| rex field=_raw "from (?<src_ip>\d+\.\d+\.\d+\.\d+)"
| stats count by src_ip
| sort - count

# 3. Alert on repeated failures
index=* "Failed password"
| rex field=_raw "from (?<src_ip>\d+\.\d+\.\d+\.\d+)"
| stats count by src_ip
| where count > 3

# 4. Failed login activity over time
index=* "Failed password"
| timechart count

# 5. Compare successful vs failed logins
index=* ("Failed password" OR "Accepted password")
| eval status=if(searchmatch("Accepted password"),"Success","Failure")
| stats count by status
