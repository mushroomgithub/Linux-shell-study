#!/bin/bash
#Program:
#	User input a filename,program will check the flowing:
#	1.)exist?2.)file/directory?3.)file permissions
#History:
#2014/01/08 First release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
echo -e "Please inut a filename,I will check the filename's type and \ pesmission. \n\n"
read -p "Input a filename: " filename
read -p "Input a filetype: " filetype
read -p "Input a perm: " perm
test -z $filename && echo "You MUST input a filename." && exit 0 test ! -e $filename && echo "The filename '$filename' DO NOT exist"&& exit 0
test -f $filename && filetype="regulare file"
test -d $filename && filetype="directory"
test -r $filename && perm="readable"
test -w $filename && perm="$perm writable"
test -x $filename && perm="$perm executble"
echo "The filename: $filename is a $filetype"
echo "And the permissions are : $perm"
