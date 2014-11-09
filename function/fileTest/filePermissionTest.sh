#!/bin/bash
#Author mogu
#Time 09/11/14

#This script is used to test file Permission

#定义用于返回错误信息的函数usage
function usage()
{
    echo "Error:Must have a parameter."
    echo "$0 filename"
    return 1
}

#定义用于测试文件权限并生成文件权限字符串的函数permission
function permission()
{
    #判断传递过来的参数是否是一个文件,如果不是则返回提示
    if [ ! -e $1 ]
    then
        echo "file not found!"
        return 1
    fi
    #判断参数1所指向的文件是否具有可读可写可执行权限
    #并将生成的权限字符串保存在变量PERMI中
    if [ -r $1 ]
    then 
        PERMI="r"
    else
        PERMI="-"
    fi

    if [ -w $1 ]
    then
        PERMI=$PERMI"w"
    else
        PERMI=$PERMI"-"
    fi
    
    if [ -x $1 ]
    then 
        PERMI=$PERMI"x"
    else
        PERMI=$PERMI"-"
    fi
    
    #函数处理完后返回生成的权限字符串
    echo $PERMI
    return 0
}


#脚本主体部分
#判断是否存在参数,如果不存在,则调用函数usage返回错误提示信息
if [ $# = 0 ]
then
    usage
    exit 1
fi

#调用函数permission并判断器其是否成功执行
if MESSAGE=`permission $1`
then
    #如果成功执行,则输出文件的权限
    echo $1":"$MESSAGE
    exit 0
else
    #如果没有成功执行,则输出提示
    echo $MESSAGE
    exit 1
fi
