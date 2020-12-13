#!/usr/bin/bash

yum -y install httpd
amazon-linux-extras install -y php7.2

echo "${aws_efs_file_system.efs-wp.dns_name}:/ /var/www/html nfs defaults,vers=4.1 0 0" >> /etc/fstab
for n in {0..60}; do
    host ${aws_efs_file_system.efs-wp.dns_name} && break
    sleep 2
done
mount -a

cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz --strip 1 -C /var/www/html
rm /tmp/latest.tar.gz
chown -R apache:apache /var/www/html

service httpd start
systemctl enable httpd

chkconfig httpd on