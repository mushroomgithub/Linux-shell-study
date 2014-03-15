#!/bin/bash
#Program:
#	Show "hello" from $1...by using case...esac
#History:
#2014/02/22 Mogu First release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

case $1 in
 "hello" )
        echo "hello,how are you?"
        ;;
 "" )
        echo "you MUST input paramnters,ex>{$0 someword}"
        ;;
 * )
	echo "Usage $0 {hello}"
	;;
esac
