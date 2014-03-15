#!/bin/bash
#Program:
#	Use id,finger command to check system account's information.#History:
#2014/02/23 Mogu First release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

users=$( cut -d ':' -f1 /etc/passwd )
for username in $users
do 
   id $username
   finger $username
done

