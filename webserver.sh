#!/bin/bash

#Update ubuntu instance
sudo apt-get update


#install ngnix
sudo apt-get install nginx -y


#install nodejs ubuntu
sudo apt-get install curl
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

#clone react app
cd /var/www/html/
sudo git clone https://github.com/NiiFrance/Mobalysis.git
cd Mobalysis/frontend
sudo npm install
sudo npm run build

#Copy Build files 
sudo cp -r /var/www/html/Mobalysis/frontend/build/* /var/www/html
sudo rm -rf index.nginx.debian.html

#Restart nginx
sudo systemctl restart nginx
