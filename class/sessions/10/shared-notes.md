

maldet -u
freshclam
cd /srv
wget "https://secure.eicar.org/eicar.com"
maldet -a /srv

cd /usr/local/maldetect/quarantine/
maldet --report 260703-0446.98827
maldet -e list


maldet -r /var/www/html/ 7 

maldet -s 260703-0446.98827

rkhunter -c --cronjob  --rwo

 aide --init

mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz

aide --check

