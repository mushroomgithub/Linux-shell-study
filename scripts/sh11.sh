#!/bin/bash
#Program:
#	you input your demobilization date,I calculate how many days
#before you demobilize.
#History:
#2014/02/21 Mogu First release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo "This program will try to calculate:"
echo "How many days before your demobilization date..."
read -p "Please input demobilization date (YYYYMMDD ex>20090401):" date2
date_d=$(echo $date2 | grep '[0-9]\{8\}')
if [ "$date_d" == "" ]; then
echo "YOU input the wrong date format..."
exit 1
fi
declare -i date_dem='date --date="$date2" +%s'
declare -i date_now='date +%s'
declare -i date_total_s=$(($date_dem - $date_now))
declare -i date_d=$(($date_total_s/60/60/24))
if [ "$date_total_s" -lt "0" ]; then
echo "you had been demobilization before:" $((-1*$date_d)) "ago"
else 
declare -i date_h=$(($(($date_total_S - $date_d*60*60*24))/60/60))
echo "you will demobilize after $date_d days and $date_h hours."
fi
