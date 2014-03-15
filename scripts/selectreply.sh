#!/bin/bash
select var in "Worker" "Doctor" "Teacher" "Farmer"
do 
echo "your \$reply is $REPLY"
echo "your favourite profession is $var"
break
done
