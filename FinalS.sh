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

echo " Installation of MARIADB"
yum install mariadb-server mariadb -y

echo "Starting of the MARIADB"
systemctl start mariadb

echo "mysql_secure_installaition"
mysql_secure_installation << EOF

Y
nel07
nel07
Y
Y
Y
Y
EOF

echo "Enable mariadb.service"
systemctl enable mariadb.service

echo "Testing of Installation"
mysqladmin -u root -p version
echo "root"


echo "Creation of Database"
mysql -u root --password=nel07 << EOF
CREATE DATABASE wordpress;
CREATE USER wordpressuser@localhost IDENTIFIED BY 'nel';
GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@localhost IDENTIFIED BY 'nel';
FLUSH PRIVILEGES;

EOF

echo "wordpress installation"
yum install php-gd -y

systemctl restart httpd

cd ~

echo "wget installation"
yum instal wget -y

echo "wordpress installation for the website"
wget http://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz

rsync -avP ~/wordpress/ /var/www/html/
mkdir /var/www/html/wp-content-uploads
chown -r apache:apache /var/www/html/*

echo "wordpress configuration"
cd /var/www/html/
cp wp-config-sample.php wp-config.php
sed -i 's/database_name_here/wordpress/g' /var/www/html/wp-config.php
sed -i 's/username_here/wordpress/g' /var/www/html/wp-config.php
sed -i 's/password_here/nel/g' /var/www/html/wp-config.php

echo "restart the httpd"
systemctl restart httpd

echo "installation on the browser"
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
yum install yum-utils -y
yum-config-manager --enable remi-php56 -y
yum instal php php-mcrpyt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo -y

echo "restart httpd again"
systemctl restart httpd

echo "end of wordpress installation"
