#!/bin/bash
#Program:
#	This program shows the usr's choice
#2014/02/20 Mogu First release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

read -p "Please input (Y/N): " yn
if [ "$yn" == "Y" ] || [ "$yn" == "y" ]; then 
        echo "Ok!,continue"
elif [ "$yn" == "N" ] || [ "$yn" == "n" ]; then
       echo "Oh! interrupt!"
else
echo "I don't know your choice is"
fi
