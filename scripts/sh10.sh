#!/bin/bash
#Program:
#	Using netstat and grep to detect WWW,SSH,FTP and MAIL services.
#History:
#2014/02/20 Mogu First release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
 
echo "NOW ,I will detect your linux server's services!"
echo -e "The www,ftp,ssh,mail will be detected!\n "
testing=$(netstat -tuln | grep ":80 ")
if [ "$testing" != "" ]; then
echo "WWW is running in your system."
fi
 testing=$(netstat -tuln | grep ":22 ")
if [ "$testing" != "" ]; then
echo "SSH is running in your system."
fi
 testing=$(netstat -tuln | grep ":21 ")
if [ "$testing" != "" ]; then
echo "FTP is running in your system."
fi
 testing=$(netstat -tuln | grep ":25 ")
if [ "$testing" != "" ]; then
echo "MAIL is running in your system."
fi

