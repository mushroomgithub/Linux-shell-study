#!/bin/bash
#Program:
#	Repeat question until user input correct answer.
#History:
#2014/02/22 Mogu First release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

while [ "$yn" != "yes" -a "$yn" != "YES" ]
do 
	read -p "Please input yes/YES to stop the program: " yn
done
echo "OK! you input the corect answer."
