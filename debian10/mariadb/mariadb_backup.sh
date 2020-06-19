#!/bin/sh
name=dbs
path=/data/mysql/
file_end=.sql

date=`date +%Y_%m_%d-%H_%M_%S`

backup_name=$name-$date$file_end

# create backup folder
mkdir -p $path

# create backup
mysqldump -x -A > $path$backup_name