#!/bin/bash
#Program:
#	This scripts only accepts the flowing parameter:one,two or three.
#History:
#2014/02/22 Mogu First release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo "this paogram will print your selection!"
read -p "input your choice: " choice
case $choice in
#case $1 in
 "one" )
	echo "your choice is ONE"
	;;
 "two" )
	echo "your choice is TWO"
	;;
 "three" )
	echo "your choice is THREE"
	;;
 * )
	echo "Usage $0 {one|two|three}"
	;;
esac
