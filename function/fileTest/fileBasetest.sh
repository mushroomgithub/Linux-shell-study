#!/bin/bash
#Author mogu
#Time 09/11/14

#This script is used to test the file type.

#定义无参数时的返回信息函数
function usage()
{
    echo "Error:Must have a parameter."
    echo "$0 filename"
    return 1
}

#定义一个函数test_file,用于判断文件类型
function test_file()
{
    #使用位置变量将文件名赋值给变量FILE_NAME
    FILE_NAME=$1
    #使用命令e判断文件是否存在
    #如果文件不存在,则返回错误提示并退出函数
    if [ ! -e $FILE_NAME ]
    then
        echo "File not found!"
        return 1
    fi

    #使用多个if判断参数1传递来的文件类型
    #判断参数1传递来的文件名是否是一个目录,如果是则返回提示
    if [ -d $FILE_NAME ]
    then
        echo "$FILE_NAME:Directory"
        return 0
    elif [ -c $FILE_NAME ]
    then 
        echo "$FILE_NAME:Character device file."
        return 0
    elif [ -b $FILE_NAME ]
    then
        echo "$FILE_NAME:Block device file."
        return 0
    elif [ -L $FILE_NAME ]
    then
        echo "$FILE_NAME:Link file."
        return 0
    elif [ -f $FILE_NAME ]
    then
        echo "$FILE_NAME:Regular file."
        return 0
    else
        echo "$FILE_NAME:Unknown file."
        return 1
    fi   
}

#脚本主体部分
#判断是否有参数传递给脚本,如果没有就调用usage函数
if [ $# = 0 ]
    then
        usage
        exit 1
fi
#判断test_file函数是否成功执行
if MESSAGE=`test_file $1`
then
    #如果函数成功执行,则返回提示信息并正常退出
    echo $MESSAGE
    exit 0
else
    #如果函数没有成功执行,则返回提示信息并错误退出
    echo $MESSAGE
    exit 1
fi

