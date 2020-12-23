#! /bin/bash
sudo apt-get -y update
sudo apt-get -y install nginx
MY_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
sudo echo "<h1>GL BASECAMP DEVOPS 1</h1><h2>$MY_IP</h2>" > /var/www/html/index*.html
sudo service nginx start