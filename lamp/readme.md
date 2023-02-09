# PHP versions | Debian 10/11
Based on: https://tecadmin.net/switch-between-multiple-php-version-on-debian/

Let's say we have php8.2 already installed and working, but we want to change it to different version such as php 8.1 because of the compatibility.

apt install php8.1

# turn off the current version of php
a2dismod php8.2

# enable new version and restart apache2
a2enmod php8.1
systemctl restart apache2

# change the "system paths"
update-alternatives --set php /usr/bin/php8.1
update-alternatives --set phar /usr/bin/phar8.1
update-alternatives --set phar.phar /usr/bin/phar.phar8.1

update-alternatives --set phpize /usr/bin/phpize8.1
update-alternatives --set php-config /usr/bin/php-config8.1

*Note that these two are only available if you have installed **-dev** module (e. g. php8.1-dev)

# verify the current version
php -v
