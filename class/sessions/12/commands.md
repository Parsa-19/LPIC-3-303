# implement DNSSEC 
it is done on 2 VMs one as master and one as slave. and also we jail named service on our dns

## stop named and start using named-chroot for jail
on both master and slave:
```
$ systemctl stop named && systemctl disable named
$ systemctl start named-chroot
```

## we use a ready script to configure named-chroot
copy every thing in `shell-scripts-and-configs` to `/var/named/chroot`
on master:
```
$ cd /var/named/chroot
$ chmod +x named.sh
$ ./named.sh
```

## configure master named.conf specific to your env
edit `/var/named/chroot/etc/named.conf`.<br>
add acl at top of the file below the initial comments:
```
acl AllowQuery { 192.168.55.0/24; };
options {
        listen-on port 53 { any; };
        listen-on-v6 port 53 { none; };
        directory       "/var/named";
        dump-file       "/var/named/data/cache_dump.db";
        statistics-file "/var/named/data/named_stats.txt";
        memstatistics-file "/var/named/data/named_mem_stats.txt";
        recursing-file  "/var/named/data/named.recursing";
        secroots-file   "/var/named/data/named.secroots";
        allow-query     { AllowQuery; };
...
```
add this at end of the file (allow transfer is ip of your slave):
```
zone "iran.ir" {
type master;
file "iran.ir.db";
allow-transfer { 192.168.55.116; };
};
```
check:
```
$ named-checkconf named.conf
```

## configure slave named.conf specific to your env
on slave: <br>
edit `/var/named/chroot/etc/named.conf`. <br>
add acl same as master to named.conf file in slave too:
```
acl AllowQuery { 192.168.55.0/24; };
options {
        listen-on port 53 { 127.0.0.1; };
        listen-on-v6 port 53 { ::1; };
        directory       "/var/named";
        dump-file       "/var/named/data/cache_dump.db";
        statistics-file "/var/named/data/named_stats.txt";
        memstatistics-file "/var/named/data/named_mem_stats.txt";
        secroots-file   "/var/named/data/named.secroots";
        recursing-file  "/var/named/data/named.recursing";
        allow-query     { AllowQuery; };
...
```
also add this zone to end of the file (in masters you type the ip of the master):
```
zone "iran.ir" {
        type slave;
        masters { 192.168.55.117; };
        file "iran.ir.db.slave";
        masterfile-format text;
};
```
check:
```
$ named-checkconf named.conf
```

## restart named-chroot service
on both master and slave:
```
$ systemctl restart named-chroot
```

## generate zsk key-pair
master:
```
$ dnssec-keygen -a NSEC3RSASHA1  -b 2048 -n ZONE  iran.ir
```
will create two files:
```
Kiran.ir.+007+54498.key      --> public
Kiran.ir.+007+54498.private  --> private
```

## generate ksk key-pair
master:
```
$ dnssec-keygen -f KSK -a NSEC3RSASHA1  -b 4096 -n ZONE  iran.ir
```
also create two files same as above:
```
Kiran.ir.+007+62323.key         --> public
Kiran.ir.+007+62323.private     --> private
``` 

## add these
master:
```
$ echo "\$INCLUDE /var/named/chroot/etc/Kiran.ir.+007+54498.key" >>  /var/named/chroot/var/named/iran.ir.db
$ echo "\$INCLUDE /var/named/chroot/etc/Kiran.ir.+007+54498.private" >>  /var/named/chroot/var/named/iran.ir.db
```