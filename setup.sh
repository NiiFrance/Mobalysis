#!/bin/bash

sudo apt-get update -y
db_user="mob_db_user"
db_pwd="mob_db_pass"
packages=('git' 'gcc' 'tar' 'gzip' 'libreadline5' 'make' 'zlib1g' 'zlib1g-dev' 'flex' 'bison' 'perl' 'python3' 'tcl' 'gettext' 'odbc-postgresql' 'libreadline6-dev')
echo "Installing PostgreSQL dependencies"
sudo apt-get install ${packages[@]} -y
sudo apt-get install postgresql -y
sudo /etc/init.d/postgresql start

sudo -u postgres createuser -s -i -d -r -l -w $db_user
sudo -u postgres psql -c "ALTER ROLE $db_user WITH PASSWORD '$db_pwd' ";
