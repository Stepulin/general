echo "Show current version of PHP"
echo "php -v" && php -v

read -p "Press ENTER to continue"

echo "PHP version to DISABLE?"
read phpdis
echo "PHP version to ENABLE?"
read phpen

echo "Disabling PHP "$phpdis""
echo "a2dismod php" && a2dismod php

echo "Enabling PHP "$phpen""
echo "a2enmod php" && a2enmod php

echo "Restarting PHP by restarting apache2 service"
echo "systemctl restart apache2" && systemctl restart apache2

echo "Show current version of PHP"
echo "php -v" && php -v

read -p "Press ENTER to continue"
