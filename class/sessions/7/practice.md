## **practice:**

**SSH**

**You want to use the SSH daemon but before you start it, secure this service according to the below instructions:**

**1- Create a user’s SSH key set(ecdsa-521).**

**2- Check your randomart public key(by ssh-keygen command).**

**3- Transfer the public key to the remote server.**

**4- Disable the password authentication in sshd\_config file and enable the public key authentication.**

**5- Restart the ssh daemon and try to connect to the remote server by ssh.**

**6- Configure these options:**

**- Disable the root login.**

**- Change the ssh port to 2222.**

**- Create a user with name “test” and just allow this user to connect to the ssh service.**

**- Change the symmetric algorithm to aes256-ctr.**

**- Check the cryptography algorithm on the ssh by nmap.**

**- Set a security banner for your ssh service.**

**7- Configure automatic logout for both local and remote users(create a bash script in /etc/profile.d/).**

**8- Share a directory that placed in /root by SSHFS (Research)**

**9- Set the fail2ban service for ssh daemon with these configurations:**

**- max connection retry: 8**

**- ban time: 86400**

**10- Try to ban your IP by failed login on ssh daemon, then unban your IP by fail2ban-client command.**



## **watch:**

**port knocking**



## **scenario:**

**یک گزارش از تیم SOC سازمان براتون ارسال شده که اشاره به اختلال شدید در وب سرور سازمان داره.**

**نمونه لاگ رو براتون توی مسیر زیر قرار دادم, لطفا بررسی کنید ببینید:**

**۱- چه حملات و مخاطراتی رو میتونید توی لاگ ها پیدا کنید(فکر کنم حدود ۵ یا ۶ حمله گذاشتم که لزومی نداره تسلط کامل به حملات وب داشته باشید و به سادگی توی همین ۲۰ یا ۳۰ خط لاگ میتونید حمله شناسایی کنید )**

**۲- چجوری میشه امن سازی انجام داد در مقابل این حملات که الان در حال وقوع هست**

**https://main.linuxbeat.com/sample.log**

**یا**

**http://185.208.79.13/sample.log**



## **arcticles:**

**https://www.digitalocean.com/community/tutorials/how-to-protect-an-nginx-server-with-fail2ban-on-ubuntu-22-04**

**-**

**https://www.cyberciti.biz/tips/linux-unix-bsd-nginx-webserver-security.html**



## **book:**

**http://185.208.79.13/modsecurity.pdf**



## **refrence:**

**https://www.youtube.com/watch?v=tMtFZdaaIhk**



