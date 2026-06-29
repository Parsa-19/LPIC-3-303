glibc
systemcalls which are important: execve, fexecve, memfd_create, mmap, mprotect, fork

$ free -h 

swappiness kernel parameter

less /proc/kallsyms

users capabilities
man capabilities

userID(UID), groupID(GID) and change userId for an existing user
useradd -u 0 john   # specifies the uid (but not permited cause 0 UID had already been existed for root user)
useradd -o -u 0 john    # allow duplicated UIDs
usermod -u 0 john   # still not permitted
nano /etc/passwd    # then change the UID to 0 for john. form now on whenever john logins with his password he will be login as root

write awk bash script to check /etc/passwd uids and ensure ther is just one 0 uid and its for root

awk -F: '($3 == "0") {print}' /etc/passwd


attackers targets on virtualization security -> esxi, vcenter 
    "       "     on linux itself -> on deprecated versions of linux servers


tune ring buffer -> overwrite kernel ring buffer with a loop to delete footprint

sysctl explorer 

kexec

EDR agent

martian address

https://capec.mitre.org/data/definitions/495.html


# requiered researches

### **kernel.printk_ratelimit** / **kernel.printk_ratelimit_burst** -> to mitigate or preventing from overwriting kernel ring buffer logs

### **SAK and SAS**

### **net.core.somaxconn**  --> the maximum number of stabished connections

### **KARL**

### kernel.yama.ptrace_scope

### bpf and ebpf (youtube video) kernel.unprivileged_bpf_disabled

### kernel.modules_disabled mirigates root kit modules

