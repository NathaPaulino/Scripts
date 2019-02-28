#!/bin/bash 
#This script add a user on a FTP server. Based on Maurício's file.
#Version 1.2 - Finished

if [[ $# -eq 1 ]];
then
  if ! (sudo adduser ${1} && mkdir /home/${1}/ftp && chown ${1}:${1} /home/${1}/ftp && ln -s /home/ftp /home/${1}/ftp && cd /home/${1}/ftp && chown -R ftp:ftp ftp && mount --bind /media/ftp /home/ftp/ftp/ && cp -R /home/ftp/.ssh /home/${1} && chown -R ${1}:${1} /home/${1}/.ssh)
 then
    echo "Unable to create a username."
    exit 1
 fi;
#Editing /etc/proftpd/proftpd.conf
  cat /etc/proftpd/proftpd.conf >> /etc/proftpd/proftpdold
  cat /etc/group >> /etc/groupold
  sed s/^[[:space:]][[:space:]]DenyALL$/\ \ AllowUser\ ${1}\\n\ \ DenyALL/g /etc/proftpd/proftpd.conf > /etc/proftpd/proftpd.conf
#Editing /etc/group
  sed s/\(^ftp[[:punct:]][[:alnum:]]\(\([[:punct:]]\)*\([[:alnum:]]\)*\)*\)/\\1,${1}/g /etc/group > /etc/group
  if ! (service proftpd restart)
  then
     echo "Unable to restart the server"
     exit 1
  else
     echo "It's work..."
  fi;
else
  echo "Use as root:./ftpuser <username>"
exit 1
fi;
