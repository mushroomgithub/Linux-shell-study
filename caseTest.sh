#!/bin/bash
#Author mogu
#Time 11/11/14

#This script is used to test case condition

#定义脚本的选项变量及其值
#选项变量的值为1,表示选项没有启用
OPTION_L=1
OPTION_H=1
OPTION_A=1
OPTION_D=1
FILE_NAME="*"

#本示例中使用的命令是ls
CMD="ls"

#如果脚本的参数个数大于0,就执行循环
while [ $# -gt 0 ]
do
#判断位置变量1中保存的是哪个参数
case "$1" in
    -l)
        OPTION_L=0
        shift
        ;;
#以下选项h,a,d与l类似
    -h)
        OPTION_H=0
        shift
        ;;
    -a)
        OPTION_A=0
        shift
        ;;
    -d)
        OPTION_D=0
        shift
        ;;
#如果位置变量1不是上面模式中的任何一个,那么一定是对象参数
#将对象参数赋值给变量FILE_NAME
    *)
        FILE_NAME=$1
        shift
esac
done
#上面的语句执行完之后,选项参数对应的变量值都应该为0
#对象参数则应该保存在变量FILE_NAME中
if [ $OPTION_H = "0" ] && [ $OPTION_L = "1" ]
then
    OPTION_H=1
fi

#如果同时使用了选项h和i,就设置在CMD变量后添加选项hl
#option_h and l
if [ $OPTION_H = "0" ] && [ $OPTION_L = "0"]
then
    CMD=$CMD" -hl"
fi

#如果只是使用了选项l,并没有使用选项h,便在CMD变量后添加选项l
#option_l
if [ $OPTION_L = "0" ] && [ $OPTION_H = "1" ]
then
    CMD=$CMD" -l"
fi

#如果使用了选项a,则将其选项添加到变量CMD最后
#a option
if [ $OPTION_A = "0" ]
then
    CMD=$CMD" -a"
fi
#如果使用了选项d,就将选项d添加到变量CMD最后
#d option
if [ $OPTION_D = "0" ]
then
    CMD=$CMD" -d"
fi

#通过调用CMD变量的方式执行变量
$CMD $FILE_NAME
