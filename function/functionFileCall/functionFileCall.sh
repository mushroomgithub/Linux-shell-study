#!/bin/bash
#Author mogu
#08/11/14

#This is a shell script to call function file
#使用执行的方法调用函数文件,使用这种方法调用函数文件时,函数文件的路径应该与脚本文件的路径相同,否则在调用时应该使用函数文件的绝对路径或相对路径
#function file : function1.sh
. ./function1.sh
  
#调用function1.sh函数文件中的函数hello
#Call function hello
echo -e "Now call function hello"
#函数调用时传递参数
hello mogu

#调用函数文件中的函数hi
#Call function hi
echo -e "Now Call function hi."
#函数调用时传递参数
hi mashuai



