#!/bin/bash
today=$(date + '%m%d%y')

cd /opt/
mkdir backs
cd /opt/backs
echo "processing mysqldump"
mysqldump -u wordpressuser -p password wordpress > wordpress_$today.sql

cd /opt/backs
echo "Evrythings gets Ready"
tar -zcf wordpress_$today.tar.gz wordpress_$today.sql

echo "Your database is successfully backed up"
