#!/bin/bash
#Author mogu

#This script is used to query the package dependencies.
#08/11/14

#定义查询函数
function query()
{
    #定义查询包的行,包名称和最大行三个变量
    LINE=0
    PACKET=null
    #使用ls命令和wc命令获取参数2的目录中的RPM包数量并赋值给变量MAX
    MAX='ls $2/*.rpm | wc -l'
    #使用一个无限循环处理包查询过程
    while true
    do
    #定义循环的内容
    #每次开始时将查询包的行增加1
    LINE=`expr $LINE +1`
    #判断当前查询的包是否大于最大包数量,如果时则返回提示的信息,并返回脚本
    if [ $MAX -lt $LINE ]
        then
        echo "Not find any package."
        #清除变量,并设置返回状态后返回
        unset LINE PACKET MAX
        return 1
    fi
    #获取变量LINE所指定的包名称
    PACKET='ls $2/*.rpm | sed -n ${LINE}p'

    #使用三个命令判断包内是否含有要查找的文件
    #先使用rpm -pql 列出变量PACKET指向的软件包内所有的文件列表
    #同时重定向错误到系统回收池/dev/null
    #再使用命令grep -v 去掉可能的错误和警告,并将错误重定向到系统回收池
    #最后使用grep $1 查询第一个参数指定的文件
    #并将查找到的结果和错误重定向到系统回收池
    rpm -pql $PACKET 2>/dev/null | grep -v "warning:" 2>/dev/null | grep $1 &>/dev/null
    #判断上一条命令是否成功执行,如果是则返回查找的包名称
    if [ $?=0 ]
    then
        #使用echo命令返回查找到的包名称
        echo $PACKET
        #清除使用的变量,设置返回状态
        unset LINE PACKET MAX
        return 0
    fi
    
    #循环结束标记
    done
}

    #脚本主体部分
    #检查脚本执行时是否带有一个参数
    #如果没有则返回错误并退出
    if [ $# != 1 ]
    then
        echo "Must have a parameter."
        echo "Usage:"$0" parameter."
        exit 1
    fi

    #设置RPM软件包所在的目录变量
    PACKET_DIR=/media
    #设置要查询的文件名称
    DEPEND_FILE=$1
    #设置用于获取函数返回值的变量
    MESSAGE=null

    #输出提示信息并并开始查询
    echo "Queryying ,PLS wait Server minutes ..."
    #调用函数并判断函数的执行状态
    #函数的第一个参数是要查询的文件名,第二个参数是RPM软件包目录
    if MESSAGE='query $DEPEND_FILE $PACKET_DIR'
    then
        #输出成功查询的提示信息,并将结果输出给用户
        echo "Query is completed."
        echo "File where the package is ::"
        echo "     "$MESSAGE
        #清除使用过的变量和函数
        unset PACKET_DIR MESSAGE DEPEND_FILE query
        #设置脚本的退出状态为无错误退出
        exit 0
    else
        #输出没有找到文件的相关提示信息,并设置返回状态为有错误退出
        echo "Query is completed."
        echo $MESSAGE
        #清除使用过的函数和变量
        unset PACKET_DIR MESSAGE DEPEND_FILE query
        exit 1
    fi

