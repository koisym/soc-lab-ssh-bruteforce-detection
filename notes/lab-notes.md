# Lab Notes

## Summary

This was my first SOC-style home lab project. The purpose of the lab was to simulate an SSH brute-force attack and detect it in Splunk using Linux authentication logs.

## What Worked

- Kali and Ubuntu were able to communicate over the virtual network
- SSH was enabled on the Ubuntu target
- Failed login activity was written to `/var/log/auth.log`
- Splunk was able to ingest the log data
- The detection query identified repeated failed attempts from the attacking IP

## Problems I Had

- Initial virtual machine networking issues
- Trouble getting internal IP addresses to show up correctly
- Splunk installation and permission issues
- Making sure the auth log was actually being monitored
- Testing the query and adjusting the threshold

## What I Learned

This project helped me better understand how authentication attacks show up in logs and how important it is to validate each stage of a detection pipeline. I also learned that building the environment is part of the skillset, not separate from it.

## Next Time

For future projects, I want to document each step more cleanly as I go and add better screenshots during the testing process.
