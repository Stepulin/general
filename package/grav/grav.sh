echo "Disable access from the internet"
iptables -D INPUT -p tcp --dport 80 -j ACCEPT
iptables -D INPUT -p tcp --dport 443 -j ACCEPT

apt install apache2 php php-curl php-fpm php-gd php-zip php-mbstring php-xml
cd /var/www/html/
rm index.html
wget https://gist.githubusercontent.com/rhukster/a727fb70d9341536d49980d1239bd97e/raw/a3078da16b894ba86f9d000bcfc4850e098199fc/htaccess_tester.php
wget https://getgrav.org/download/core/grav-admin/1.6.31 -O grav.zip
unzip grav.zip
cd grav-admin/
cp * -r /var/www/html/
cd ..
rm -r grav-admin/
rm grav.zip

wget https://raw.githubusercontent.com/Stepulin/general/master/package/grav/grav.conf -O /etc/apache2/sites-available/grav.conf
a2dissite 000-default.conf
a2ensite grav.conf
a2enmod ssl socache_shmcb rewrite headers proxy proxy_fcgi
a2enconf php7.3-fpm

chown -R www-data:www-data /var/www/html

apachectl configtest
#cd /var/www/html/
#wget https://raw.githubusercontent.com/getgrav/grav/develop/.htaccess
#systemctl restart apache2
