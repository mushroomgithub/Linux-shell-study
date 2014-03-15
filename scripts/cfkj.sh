#!/bin/bash
for (( i =1; i <= 9; i++ ))
 do
   for (( j =1; j <= i; j++ ))
     do 
       let "tmp = i * j"
       echo -n "$i*$j=$tmp  "
     done
   echo ""
 done
