#! /bin/bash
sudo apt-get -y update
sudo apt-get -y install nginx
sudo echo "<h1>GL BASECAMP DEVOPS 222222</h1>" > /var/www/html/index*.html
sudo service nginx start