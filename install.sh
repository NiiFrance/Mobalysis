#!/bin/bash

sys_user="mob_app_usr"
user_dir=/home/$sys_user

echo "creating user with home directory..."
sudo useradd -m -d $user_dir $sys_user

echo "Cloning forked repository into home directory of user..."
cd $user_dir

echo "removing existing files from user directory..."
sudo rm -rf $user_dir/*
sudo git clone https://github.com/NiiFrance/Mobalysis.git

echo "DBNAME=mobalytics 
DBUSER=mob_db_user 
DBPASS=mob_db_pass 
DBHOST=localhost 
DBPORT=5432  " >> ~/.bashrc
source ~/.bashrc

echo "Creating Virtual Environment................"
sudo python3 -m venv env
source env/bin/activate

echo "installing application packages.............."
pip install -r ./backend/requirements.txt
