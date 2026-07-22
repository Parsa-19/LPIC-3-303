
;[root@master 01:58:32 ~]
----> systemctl stop named

[root@master 01:59:01 ~]
----> systemctl start named-chroot


master:
    wget http://185.208.79.13/named.sh
    chmod +x named.sh
    
named.sh:
    #!/bin/bash
# This script configure bind on your centos server
wget http://185.208.79.13/named.conf
wget http://185.208.79.13/iran.ir.db
cp -f named.conf  /var/named/chroot/etc/
cp -f iran.ir.db  /var/named/chroot/var/named/
echo "nameserver 127.0.0.1" > /etc/resolv.conf
chattr +i /etc/resolv.conf
systemctl stop firewalld
systemctl disable firewalld
dig mx iran.ir

    
    
[root@master 02:18:15 etc]
----> systemctl stop named-chroot

[root@master 02:19:17 etc]
----> mv named.conf.1  named.conf

[root@master 02:19:21 etc]
----> systemctl start named-chroot


/usr/libexec/setup-named-chroot.sh  /var/named/chroot/  on


acl AllowQuery { 192.168.56.0/24; };

slave(named.conf):
    acl AllowQuery { 192.168.56.0/24; };
    
    
zone "iran.ir" {
type slave;
masters { 192.168.56.104; };
file "iran.ir.db.slave";
masterfile-format text;
};



master and slave:
    systemctl restart named-chroot
    


master:
    dnssec-keygen -a NSEC3RSASHA1  -b 2048 -n ZONE  iran.ir
    
dnssec-keygen -f KSK   -a NSEC3RSASHA1  -b 4096 -n ZONE  iran.ir



[root@master 03:47:25 etc]
----> echo "\$INCLUDE /var/named/chroot/etc/Kiran.ir.+007+03029.key" >>  /var/named/chroot/var/named/iran.ir.db

[root@master 03:48:11 etc]
----> echo "\$INCLUDE /var/named/chroot/etc/Kiran.ir.+007+31485.key" >>  /var/named/chroot/var/named/iran.ir.db


dnssec-signzone -A -3 $(head -c 1000 /dev/random | sha1sum | cut -b 1-16) -N INCREMENT -o  iran.ir -t /var/named/chroot/var/named/iran.ir.db


also-notify { 192.168.56.102; };



slave:
       47   dig @192.168.56.104 iran.ir
   48   dig @192.168.56.104 iran.ir +dnssec
   49   dig @192.168.56.104 iran.ir RRSIG
   50   dig @192.168.56.104 iran.ir DNSKEY

-----------------------------
cd /usr/share/xml/scap/ssg/content/

oscap  info  ssg-rl8-ds.xml

oscap  xccdf eval --results jafar.xml   --profile xccdf_org.ssgproject.content_profile_stig  ssg-rl8-ds.xml

oscap xccdf generate report jafar.xml > /var/www/html/jafar.html