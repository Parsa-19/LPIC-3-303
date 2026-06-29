
# sysctl
```
sysctl -a

sysctl -w vm.swappiness=10
sysctl vm.swappiness

/etc/sysctl.conf
/etc/sysctl.d/*.conf

sysctl -w net.ipv4.ip_forward=1 >> /etc/sysctl.d/custom-ip-forward.conf
sysctl -p /etc/sysctl.d/custom-ip-forward.conf
```

# tunable kernel parameters
## 1. **kernel.kptr_restrict**
(kernel pointer restriction) <br>
It controls how much information about kernel pointer addresses is exposed to userspace.<br>
in another way it allow you to see kernel memory addresses in some locations.
parameter values:
 - 0 = disable
 - 1 = users that have capability of syslog (CAP_SYSLOG) are allowed to see kernel addresses in some files
 - 2 = Hide from everyone even root

kernel addresses are exposed via:
 - `/proc/kallsyms`
 - kernel logs (`dmesg`)
 - some debugging inerfaces
use of the prameter:
``` 
$ sysctl kernel.kptr_restrict
$ less /proc/kallsyms
$ sysctl -w kernel.kptr_restrict=2
$ less /proc/kallsyms
```

## 2. **kernel.dmesg_restrict**
it lets you hid all kernel ring buffers log information due to security risks. 
```
$ sysctl -w kernel.dmesg_restrict=1
$ su john
$ dmesg     # you are not allowed to see kernel ring buffer now
```

## 3. **kernel.printk**
determines the system log level in four columns e.g. : <br>
kernel.printk="7  4  1  7"

each number in the value specifies a log level;<br>
log levels:
 - 0	KERN_EMERG	An emergency condition; the system is probably dead
 - 1	KERN_ALERT	A problem that requires immediate attention
 - 2	KERN_CRIT	A critical condition
 - 3	KERN_ERR	An error
 - 4	KERN_WARNING	A warning
 - 5	KERN_NOTICE	A normal, but perhaps noteworthy, condition
 - 6	KERN_INFO	An informational message
 - 7	KERN_DEBUG	A debug message

columns:<br>
console_loglevel - default_message_loglevel - minimum_console_loglevel - default_console_loglevel (during boot time)

how to use:
```
$ sysctl -w kernel.printk="3 3 3 3"
$ sysctl kernel.printk
```

## 4. **kernel.kexec_load_disabled**
lets you to disable load of another kernel into the existing system. 
>[!TIP]
> to load another kernel into the system:<br>
> `kexec -l /boot/vmlinuz-$(uname -r) --initrd=/boot/initramfs-$(uname -r).img --command-line="$(cat /proc/cmdline)"`

how to use:
```
$ kexec -l /boot/vmlinuz-$(uname -r) --initrd=/boot/initramfs-$(uname -r).img --command-line="$(cat /proc/cmdline)
$ sysctl -w kernel.kexec_load_disabled=1
$ kexec -l /boot/vmlinuz-$(uname -r) --initrd=/boot/initramfs-$(uname -r).img --command-line="$(cat /proc/cmdline)
```
this parameter prevents you from loading unsigned kernel images

## 5. **kernel.sysrq**
this is a feature on os that provides you some system requests shortcuts which can reboot and some more. you need to disable it on production environments:
```
sysctl -w kernel.sysrq=0
```
> [!WARNING]
> you can trigger the sysrq options anyways by echoing its request commands to a file `/proc/sysrq-trigger` e.g.: <br>
> `echo o > /proc/sysrq-trigger` => o shut your system off <br> 
> `echo u > /proc/sysrq-trigger` => u remount all mounted filesystems read-only. to remount them as read/write filesystems again run `mount -o remount,rw /dev/mapper/rl-root` <br>

## 6. **kernel.randomize_va_space**
kernel has a defense mechanism named Address Space Layout Randomization(ASLR) which you can enable.<br>
values:
 - 0 = disable  
 - 1 = randomization is enabled on shared libraries, stack memory mappings, vdso, PIE but it doesnt randomize the heap.
 - 2 = everything including heap and all supported process memory regions.

how to use:
```
sysctl -w kernel.randomize_va_space=2
```

## 7. **net.ipv4.tcp_syncookies**
durring SYN_flood attacks, the attacker sends syn request to server and then the server creates the half open connection by allociating dedicated memory in syn_backlog_qeue and then server answers by SYN-ACK but the attacker never ACK to create the established connection and causes the server memory to get filled.<br>
with this parameter:<br>
Instead of immediately allocating memory, the server encodes the necessary connection information into the sequence number of the SYN-ACK.
```
Client                     Server

SYN ---------------------->

                  No memory allocated

      <-------------------- SYN-ACK
           (cookie in sequence number)

ACK ---------------------->

Cookie verified

Now allocate memory

Connection established
```
If the client never responds, the server never allocates resources.

how to use:
```
sysctl -w net.ipv4.tcp_syncookies=1
```

## 8. **net.ipv4.conf.all.rp_filter** and **net.ipv4.conf.default.rp_filter**
these controls reverse path filtering (RPF) which is anti-spoofing feature in network. <br>
they prevents packets from forged source IP addresses to be accepted.

- all.rp_filter: it works on all existing network interfaces.
- default.rp_filter: works for new interfaces created after boot (like docker containers in bridge mode)

```
sysctl -w net.ipv4.conf.all.rp_filter=1
sysctl -w net.ipv4.conf.default.rp_filter=1
```

## 9. **net.ipv4.conf.all.log_martians**
martian addresses are none routable IP addresses in Internet:
 - 0.0.0.0/8
 - 127.0.0.0/8
 - 192.0.2.0/24
 - 224.0.0.0/4
 - 240.0.0.0/4

attacker can use them to create a DOS with spoofed IP addresses and this parameter here log the martian addresses and displays the IP on server's console durring the attack which is messy but could be used.

how to use:
```
sysctl -w net.ipv4.conf.all.log_martians=1
```

## 10. **net.ipv4.ipfrag_low_thresh** and **net.ipv4.ipfrag_high_thresh**
The net.ipv4.ipfrag_low_thresh and net.ipv4.ipfrag_high_thresh kernel parameters control the amount of memory that the Linux kernel may use for storing incomplete IPv4 packet fragments during the reassembly process. When a fragmented IP packet is received, the kernel temporarily stores its fragments until the entire packet has arrived and can be reassembled. The ipfrag_high_thresh parameter defines the upper memory limit for the fragment reassembly cache. If memory usage exceeds this threshold, the kernel begins evicting incomplete fragment queues to reclaim memory. Cleanup continues until memory usage falls below ipfrag_low_thresh, which serves as the lower threshold at which reclamation stops. Using separate high and low thresholds introduces hysteresis, preventing frequent cleanup cycles and improving efficiency while protecting the system against excessive memory consumption caused by fragmented traffic or fragmentation-based denial-of-service attacks.

how to use:
```
sysctl -w net.ipv4.ipfrag_low_thresh=2000000
sysctl -w net.ipv4.ipfrag_high_thresh=3200000
```

## 11. **net.ipv4.tcp_max_syn_backlog**
<img src="syn_backlog.png" alt="" style="display: inline-block; height: 1.25rem; width: auto; vertical-align: text-bottom; margin: 0 0.25rem;"/>


## 12. **net.ipv4. **

## 13. **net.ipv4. **

## 14. **net.ipv4. **

## 15. **net.ipv4. **

## 16. **net.ipv4. **

## 17. **net.ipv4. **

## 18. **net.ipv4. **
