#!/bin/bash
var1=20
var2=3.14159
var3=`echo "scale=5;$var1^2" | bc`
var4=`echo "scale=5;$var2*$var3" | bc`
echo "The area of this circle is:$var4"
