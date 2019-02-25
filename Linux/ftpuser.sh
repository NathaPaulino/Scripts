#!/bin/bash
#This script add a user on a FTP server. Based on Maurício's file.
#Version 1.0 - Finishing the files

if [[ $# -eq 1 ]];
then
 if ! (adduser ${1} && mkdir /home/${1}/ftp && chown ${1}:${1} /home/${1}/ftp && ln -s /home/ftp /home/${1}/ftp && cd /home/${1}/ftp && chown -R ftp:ftp ftp && mount --bind /media/ftp /home/ftp/ftp/ && cp -R /home/ftp/.ssh /home/${1} && chown -R ${1}:${1} /home/${1}/.ssh)
 then
    echo "Unable to create a username."
    exit 1
 fi;
#Editing /etc/proftpd/proftpd.config
  sed -e -E "s/^ftp*/^ftp*,${1}\$/g"
#Editing /etc/group
  sed -e -E "s/^ftp*/^ftp*,${1}\$/g"
else
  echo "Use:./ftpuser <username>."
exit 1
fi;
