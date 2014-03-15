#!/bin/bash
#Program:
#	Use function to repeat information.
#History:
#2014/02/22 Mogu First release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
 
function printit(){
	echo -n "your choice is "
}

echo "This program will print your selection!"
case $1 in
 "one" )
	printit; echo $1 | tr 'a-z' 'A-Z'
	;;
 "two" )
	printit; echo $1 | tr 'a-z' 'A-Z'
	;;
 "three" )
	printit; echo $1 | tr 'a-z' 'A-Z'
	;;
 *)
	echo "Usage $0 {one|two|three}"
	;;
esac
