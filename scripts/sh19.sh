#!/bin/bash
#Program:
#	Try do calculate 1+2+3+...+${your_input}.
#History:
#2014/02/23 Mogu First release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

read -p "Please input number,I will count for 1+2+3+...+your_input:" nu
s=0
for((i=0;i<=$nu;i++))
do 
	s=$(($s+$i))
done
echo "The result of '1+2+3+...+$nu' is ==> $s"

