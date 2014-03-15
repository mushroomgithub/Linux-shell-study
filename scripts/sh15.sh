#!/bin/bash
#Program:
#	Using for...loop three animals
#History:
#2014/02/23 Mogu First release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

for animal in dog cat elephant
do 
  echo "there are ${animal}s"
done
