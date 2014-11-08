#!/bin/bash
#Author mogu
#This is a Function definition scripts
#08/11/14

#定义函数hello
#Definition Function hello
hello()
{
    echo -e "Now is the Function hello"
    echo "Hello! "$1"."
    return
}

#定义函数hi
#Definition Function hi
function hi()
{
    #使用echo命令输出字符串
    echo -e "Now is the Function hi."
    echo -e "Hi! "$1"."
    return
}
