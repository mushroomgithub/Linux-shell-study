#!/bin/bash
# Program:
#	You input your demobilization date, I calculate how many days
#	before you demobilize.
# History:
# 2005/08/29	VBird	First release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# 1. 告知使用者這支程式的用途，並且告知應該如何輸入日期格式？
echo "This program will try to calculate :"
echo "How many days before your demobilization date..."
read -p "Please input your demobilization date (YYYYMMDD ex>20090401): " date2

# 2. 測試一下，這個輸入的內容是否正確？利用正規表示法囉～
date_d=$(echo $date2 |grep '[0-9]\{8\}')   # 看看是否有八個數字
if [ "$date_d" == "" ]; then
	echo "You input the wrong date format...."
	exit 1
fi

# 3. 開始計算日期囉～
declare -i date_dem=`date --date="$date2" +%s`    # 退伍日期秒數
declare -i date_now=`date +%s`                    # 現在日期秒數
declare -i date_total_s=$(($date_dem-$date_now))  # 剩餘秒數統計
declare -i date_d=$(($date_total_s/60/60/24))     # 轉為日數
if [ "$date_total_s" -lt "0" ]; then              # 判斷是否已退伍
	echo "You had been demobilization before: " $((-1*$date_d)) " ago"
else
	declare -i date_h=$(($(($date_total_s-$date_d*60*60*24))/60/60))
	echo "You will demobilize after $date_d days and $date_h hours."
fi
