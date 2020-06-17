#!/bin/sh
# unzip: tar -xjvf name.tar.bz2

#values
name=server01
path=/data/backups/
zip_end=.tar.bz2
ssh_ip=0.0.0.0
ssh_user=user
ssh_password=password
ssh_port=22
ssh_path=/backups/server01/

date=`date +%Y_%m_%d-%H_%M_%S`

backup_name=$name-$date$zip_end

echo 'Start backup.'

# install required programs
apt-get update
apt-get install sshpass openssh-client -y

# create backup folder
mkdir -p $path

# erstelle backup
tar -cvjSf \
$path$backup_name \
--exclude=$path'*' \
/

# transfer backup
# local backup will be deleted if the transfer was successful
sshpass -p $ssh_password \
scp -P $ssh_port \
$path$backup_name \
$ssh_user@$ssh_ip:$ssh_path \
&& \
rm $path$backup_name

echo 'Backup finished.'