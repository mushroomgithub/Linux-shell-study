#!/bin/bash
#Author mogu
#Time 11/11/14
#This script is used for network monitor by ping command!
#设置用于保存网络状态和路由状态的日志文件变量
NET_STATUS_LOG="/root/netstatus.log"
NET_TRACEROUTE_LOG="/root/net_traceroute.log"

#使用true启用一个无限循环
while true
do 
    #将当前日期,时间保存在变量DATE中
    DATE=`date +"%Y-%m-%d %H:%M:%S"`
    #使用ping命令发送三个数据包,测i与192.168.118.91的连通性
    ping 192.168.118.91 -c 3 &>/dev/null
    #如果测试成功,就将当前日期,时间和网络状态写入网络日至文件中
    if [ $? = 0 ]
    then
        echo "$DATE   YES" >> $NET_STATUS_LOG
    else
        #如果测试失败,就写入日志,并测试与网关之间的连通性
        echo "$DATE  NO" >> $NET_STATUS_LOG
        ping 192.168.115.1 -c 3 &>/dev/null
        #使用if语句判断与网关之间的连通性
        if [ $? = 0 ]
        then
        #如果网关测试通过,就将日志和traceroute命令的输出保存在日志文件中
        #以便管理员排除错误
        echo "####################$DATE Begin#####################" >>$NET_TRACEROUTE_LOG
        echo "traceroute:" >>$NET_TRACEROUTE_LOG
        traceroute 192.168.118.91 >> $NET_TRACEROUTE_LOG
        echo "####################$DATE End######################3" >>$NET_TRACEROUTE_LOG
    else
        #如果网关测试失败,就写入日之中
        echo "Disconnected with the default gateway." >> $NET_STATUS_LOG
    fi
fi
#设置测试间隔为60秒
    sleep 60
done
