#!/bin/bash
#Program:
#	Check $1 is equal to "hello"
#History:
#2014/02/20 Mogu First release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
 
if [ "$1" == "hello" ]; then
     echo "hello!,how are you?"
elif [ "$1" == "" ]; then
     echo "you MUST input parameters,ex>{$0 someword}"
else
     echo "The only parameter is 'hello',ex>{$0 hello}"
fi
