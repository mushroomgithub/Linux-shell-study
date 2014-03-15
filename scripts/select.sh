#!/bin/bash
echo "Select what's your favorite color? "
select color in "red" "green" "black" "white"
do 
break
done
echo "Your slect is the color $color"

