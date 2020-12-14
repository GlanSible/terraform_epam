#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
cat <<EOF > /var/www/html/index.html
<html>
<body bgcolor="black">
<h2><font color="gold">Build by Terraform <font color="red"> v0.13</font></h2><br>
<font color="green">Server PrivateIP: <font color="aqua">$myip<br><br>
Owner ${f_name} ${l_name} <br>

%{for x in names ~}
Hello to ${x} from ${f_name}<br>
%{ endfor ~}

<font color="magenta">
<b>Version 3.0</b>
</html>
EOF

sudo service httpd start
chkconfig httpd on