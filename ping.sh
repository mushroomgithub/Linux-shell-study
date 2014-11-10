#!/bin/bash
#Author mogu
#10/11/14

#This script is used to test ip ping.

function usage()
{
    echo "Error:Must have a IP Address as the S1"
    echo "usage:$0:the ip Address to check"
    return 1
}
if [ $# = 0 ]
then
    usage
    exit 1
fi

#使用ping命令ping $1,发送三个数据包测试与主机之间的连通性
if `ping $1 -c 5 &>/dev/null`
then
#如果能联通,就输出提示信息,然后退出
    echo "Host can communication with the target."
    exit 0
else
#否则认为与主机之间不可通信,给出提示,然后退出
    echo "Host can not communication with the target.,Pls check your conect!"
    exit 1
fi

