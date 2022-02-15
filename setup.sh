#!/bin/bash
echo "updating and checking for package updates..."
sudo apt-get update -y
db_user="mob_db_user"
db_pwd="mob_db_pass"
sys_user="mob_app_usr"
user_dir=/home/$sys_user
packages=('git' 'gcc' 'tar' 'gzip' 'libreadline5' 'make' 'zlib1g' 'zlib1g-dev' 'flex' 'bison' 'perl' 'python3' 'tcl' 'gettext' 'odbc-postgresql' 'libreadline6-dev')

echo "Installing PostgreSQL dependencies"
sudo apt-get install ${packages[@]} -y

echo "installing postgres..."
sudo apt-get install postgresql -y
sudo /etc/init.d/postgresql start

echo "adding user to postgres with password..."
sudo -u postgres createuser -s -i -d -r -l -w $db_user
sudo -u postgres psql -c "ALTER ROLE $db_user WITH PASSWORD '$db_pwd' ";

echo "creating user with home directory..."
sudo useradd -m -d $user_dir $sys_user

echo "Cloning forked repository into home directory of user..."
cd $user_dir

echo "removing existing files from user directory..."
sudo rm -rf $user_dir/*
sudo git clone https://github.com/NiiFrance/Mobalysis.git

echo "Installing python3 virtual environment........................."
sudo apt install python3-virtualenv

echo "Creating an empty database..."

set -e

DB_NAME="mobalytics"
DB_USER="mob_db_user"
sudo su postgres <<EOF
createdb  $DB_NAME;
psql -c "grant all privileges on database $DB_NAME to $DB_USER;"
echo "Postgres User '$DB_USER' and database '$DB_NAME' created."
EOF
