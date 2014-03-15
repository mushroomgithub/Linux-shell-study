#!/bin/bash
#Program:
#	Use ping command to check the network's PC state.
#History:
#2014/02/23 Mogu First release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

network="192.168.1"
for sitenu in $(seq 1 101)
do 
ping -c 1 -w 1 ${network}.${sitenu} &> /dev/null && result=0 || result=1
if [ "$result" == 0 ] ; then
	echo "server${network}.${sitenu} is UP."
else
	echo "server${network}.${sitenu} is DOWN."
fi
done
