auditctl -l
# audit configureation
nano /etc/audit/auditd.conf

# audit logs
less /var/log/audit/audit.log

# audit rule files
nano /etc/audit/audit.rules
nano /etc/audit/rules.d/audit.rules

# bultin audit rules value assignment
auditctl -b 8192
auditctl -f 2

# list manual added rules
auditctl -l

# status auditctl
auditctl -s

# define watch rule
auditctl -w /etc/passwd -p rwxa -k passwd_monitor
>[!NOTE]
> also equal to `auditctl -a always,exit -F path=/etc/passwd -F perm=war -k passwd_changes`

# delete watch rule
auditctl -W /etc/passwd -p rwxa -k passwd_monitor

# search in audit logs
ausearch -i
ausearch -i -k passwd_monitor
ausearch -i -x useradd
ausearch -i -ua 1000
ausearch -i --event 4263

# reload auditd service after adding or removing rules in .rules files
service auditd reload
auditctl -R /etc/audit/rules.d/audit.rules

# generate a report
aureport
aureport -x
aureport -x --summary
aureport --start 03/15/2023 00:00:00 --end 02/19/2026 00:00:00
aureport --login -i
aureport --login --summary -i

# see all systemcalls and their code-numbers
ausyscall --dump

# systemcall rules
auditctl -a always,exit -F arch=b64 -F path=/bin/su -F perm=x -F "auid>=1000" -F "auid!=4294967295" -k su_execute
auditctl -a always,exit -F arch=b64 -S execve -F auid=1000 -F key=suspic_user
auditctl -a always,exit -F arch=b64 -S ptrace -k proc_inject
> [!NOTE]
> you can use this command `grep -R "UINT_MAX" /usr/include/limits.h` to find the unsigned ID `4294967295` everytime.

# persist the rules
auditctl -l >> /etc/audit/rules.d/custom.rules 