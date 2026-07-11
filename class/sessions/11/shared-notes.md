auditctl -w /etc/passwd -p w -k passwd_changed

auditctl -w /etc/shadow -p w -k shadow_changed

auditctl -W /etc/passwd -p raxw -k passwd_changed2

cat /var/log/audit/audit.log | grep -ia shadow_changed

ausyscall --dump 


ausauid>=1000arch -i -x useradd
ausearch -i  -k shadow_changed
 ausearch -i -ua 1000 
 ausearch -i --event 256
 
aureport --start 03/15/2023 00:00:00 --end 02/19/2026 00:00:00 

aureport -x --summary

aureport -x 

[root@localhost 03:57:32 ~]
----> aureport -i --login  

[root@localhost 03:57:36 ~]
----> aureport -i --login  --summary 


auditctl -a always,exit -F path=/bin/su  -F perm=x -F "auid>=1000" -F "auid!=4294967295"   -k T1078



auditctl -a always,exit -F arch=b64 -S execve -F "auid=1000" -k HACKER_EXEC


ausearch -i -k HACKER_EXEC

wget http://185.208.79.13/ptrace.py

auditctl -a always,exit -F arch=b64 -S ptrace -k Proccess_Injection

-F "auid>=1000"


auditctl -a always,exit -F arch=b64  -S memfd_create -F "auid>=1000" -k Fileless_Malware