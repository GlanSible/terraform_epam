#!/bin/bash

yum -y update
yum -y install httpd

wget -O https://wordpress.org/latest.tar.gz && tar -xzf latest.tar.gz
mv wordpress /var/www/html

sudo service httpd start
chkconfig httpd on
