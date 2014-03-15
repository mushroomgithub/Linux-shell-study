#!/bin/bash
((a=2009))
echo "The initial value of a is $a"
((a++))
echo "After a++ ,the value of a is $a"
((++a))
echo "After ++a, the value of a is $a"
((a--))
echo "After a-- ,the value of a is $a"
((--a))
echo "After --a, the value of a is $a"

