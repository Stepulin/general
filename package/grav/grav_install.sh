wget https://raw.githubusercontent.com/Stepulin/general/master/package/grav/grav.sh
bash grav.sh

echo "yourdomain?"
read yourdomain

cp grav.conf /etc/apache2/sites-available/
mkdir /etc/ssl/private/$yourdomain
cp ca.crt $yourdomain.crt $yourdomain.key /etc/ssl/private/$yourdomain/
cat /etc/apache2/sites-available/grav.conf
apachectl configtest
systemctl restart apache2
cd /var/www/html/
wget https://raw.githubusercontent.com/getgrav/grav/develop/.htaccess
rm htaccess_tester.php
chown -R www-data:www-data /var/www/html
systemctl restart apache2
