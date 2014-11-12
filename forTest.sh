#!/bin/bash
#Author mogu
#Time 11/11/14

#This script is used to test for statement

#定义变量I,并为其赋值为1
I=1
#使用for语句处理一个值列表
#for 语句会将列表中的每一个数字赋值给变量LOOP并执行do和done之间的语句
#for LOOP in 1 2 3 4 5 6 7 8 9
#使用数组代替上面的列表方式
J="1 2 3 4 5 6 7 8 9"
for LOOP in $J
do
    #显示当前是第几次执行循环
    echo "loop:"$I
    #显示当前循环中变量LOOP的值
    echo "LOOP="$LOOP
    #将变量I的值加1
    I=`expr $I + 1`
done
exit 0
