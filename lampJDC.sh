#!/bin/bash
echo "Installation of Apache HTTP "
yum install httpd -y
echo " Starting of the Apache"
systemctl start httpd.service

echo "Adding of the Firrewall Rules"
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=443/tcp

echo "Reloading of Firewall"
firewall-cmd --reload

echo "End of the Installation"

echo " Installation of PHP APACHE"
yum install php php-mysql -y

echo "Restarting the HTTPD.service"
systemctl restart httpd.service

echo "Installing of the php-fpm"
yum install php-fpm -y

echo "<?php phpinfo();?>" > /var/www/html/info.php

echo "End of the Installation of PHP"
