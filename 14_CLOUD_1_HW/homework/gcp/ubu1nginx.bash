#! /bin/bash
sudo apt-get -y update
sudo apt-get -y install nginx
sudo echo "<h1> ${hostname} </h1>" > /var/www/html/index*.html
sudo service nginx start