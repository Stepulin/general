wget https://raw.githubusercontent.com/Stepulin/general/master/package/grav/grav.sh
bash grav.sh
cp grav.conf /etc/apache2/sites-available/
mkdir /etc/ssl/private/yourdomian
cp ca.crt yourdomian.crt yourdomian.key /etc/ssl/private/yourdomian/
cat /etc/apache2/sites-available/grav.conf
apachectl configtest
systemctl restart apache2
cd /var/www/html/
wget https://raw.githubusercontent.com/getgrav/grav/develop/.htaccess
rm htaccess_tester.php
chown -R www-data:www-data /var/www/html
systemctl restart apache2
