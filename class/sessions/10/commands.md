
## check if the current vm is in virtual machine or baremetal
```
systemd-detect-virt
```

## fire jail
```
/usr/local/etc/firejail/*.profile
firejail vim
```

-------------------

## installation of LMD
```
git clone https://github.com/rfxn/linux-malware-detect.git
cd linux-malware-detect
./install.sh
```

## isntallation of ClamAV
```
yum -y install epel-release
yum -y install clamav clamav-devel
freshclam
clamscan /srv/malware.file
```

## configure LMD and enable using ClamAV 
`nano /usr/local/maldetect/conf.maldet`
```
email_alert="1"
email_addr="your@email.com"

cron_prune_days="90"

scan_clamscan="1"

scan_max_depth="25"
scan_min_filesize="19"
scan_max_filesize="4096k"

scan_ignore_root="0"

scan_tmpdir_paths="/tmp /var/tmp /dev/shm /var/fcgi_ipc"

scan_cpunice="19"
scan_ionice="6"
scan_cpulimit="0"

quarantine_hits="1"
quarantine_clean="0"

```

# SCAN using LMD
```
cd /srv
wget https://secure.eicar.org/eicar_com2.zip
wget https://secure.eicar.org/eicar_com.zip
wget https://secure.eicar.org/eicar.com.txt
wget https://secure.eicar.org/eicar.com
```
```
maldet -u
maldet -a /srv 
```
> [!NOTICE]
> to be able to run maldet on malware file, you need to check the file owner. by `scan_ignore_root` enabled with value 1 if the files are owned by root maldet wont scan them but if the value is 0 and disabled it will even scan root owned files too.
```
maldet --report 260713-0958.173767
ls /usr/local/maldetect/quarantine
```

## restore quarantine files
```
maldet -e list
maldet -s 260713-0958.173767
```

## all signitures for LMD is in
```
ls /usr/local/maldetect/sigs
```

## scan just the files that are created or modified in past 7 days 
```
maldet -r /var/www/html 7
```

-------------------

## rkhunter
```
rkhunter --update

rkhunter -c
rkhunter -c --cronjob --rwo

# choose the program with warning and get it's hash 
sha256sum /usr/bin/egrep
md5sum /usr/bin/egrep

# paste the hash in this site (in search tab)
https://www.virustotal.com/gui/home/upload

crontab -e -u root
> 20 20 * * * /bin/rkhunter -c --cronjob --rwo
```

-------------------

## AIDE (FIM)
aide --init
nano /etc/aide.conf
mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz

aide --check  # var/log/aide/aide.log
crontab -e -u root
> 30 21 * * * /usr/sbin/aide --check

aide --update 
mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz