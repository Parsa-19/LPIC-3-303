
  sysctl -w vm.swappiness=10
 
  sysctl  vm.swappiness
  sysctl -w vm.swappiness=20 >> /etc/sysctl.d/askari.conf
  
   sysctl -p /etc/sysctl.d/askari.conf
   

 
sysctl -w kernel.kptr_restrict=2
 awk -F: '($3 == "0") {print}' /etc/passwd
 
sysctl -w kernel.dmesg_restrict=1
https://sysctl-explorer.net/

---------
console_loglevel  -   default_message_loglevel  -   minimum_console_loglevel   -   default_console_loglevel (During Boot-Time)   
------------
sysctl -w kernel.printk="3 3 3 3"
------

kexec -l /boot/vmlinuz-$(uname -r)   --initrd=/boot/initramfs-$(uname -r).img   --command-line="$(cat /proc/cmdline)"

-------
sysctl -w kernel.kexec_load_disabled=1
sysctl -w kernel.sysrq=0

[root@localhost 04:22:28 ~]
----> sysctl -w net.ipv4.conf.all.log_martians=1
net.ipv4.conf.all.log_martians = 1

[root@localhost 04:23:00 ~]
----> sysctl -w net.ipv4.conf.default.rp_filter=1

 sysctl -w net.ipv4.ipfrag_high_thresh=3200000 

 sysctl -w net.ipv4.ipfrag_low_thresh=2000000 


sysctl -w net.ipv4.tcp_max_syn_backlog=8192

sysctl -w net.ipv4.tcp_synack_retries=3


sysctl -w  net.ipv4.tcp_keepalive_time=2000

sysctl -w net.ipv4.tcp_keepalive_probes=4

sysctl -w net.ipv4.tcp_keepalive_intvl=30

systemctl mask ctrl-alt-del.target

lynis audit system

code.sh:
    for i in `seq 1 80`
do      
nc -nvlp 120$i    &
done 


[hacker@localhost ~]$ ulimit -u 100
[hacker@localhost ~]$ ulimit -u   
[hacker@localhost ~]$ ./code.sh  
---------------------
proc                    /proc                   proc    hidepid=2       0       0

mount -o remount proc

systemctl set-property httpd.service  MemoryAccounting=1 CPUAccounting=1

systemctl set-property httpd.service  CPUQuota=30%  MemoryLimit=300M

systemctl set-property user-1000.slice  MemoryAccounting=1 CPUAccounting=1 

systemctl set-property user-1000.slice  CPUQuota=30%  MemoryLimit=300M