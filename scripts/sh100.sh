#!/bin/bash
# Program:
# 	Using netstat and grep to detect WWW,SSH,FTP and Mail services.
# History:
# 2005/08/28	VBird	First release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# 1. 先作一些告知的動作而已～
echo "Now, I will detect your Linux server's services!"
echo -e "The www, ftp, ssh, and mail will be detect! \n"

# 2. 開始進行一些測試的工作，並且也輸出一些資訊囉！
testing=$(netstat -tuln | grep ":80 ")   # 偵測看 port 80 在否？
if [ "$testing" != "" ]; then
	echo "WWW is running in your system."
fi
testing=$(netstat -tuln | grep ":22 ")   # 偵測看 port 22 在否？
if [ "$testing" != "" ]; then
	echo "SSH is running in your system."
fi
testing=$(netstat -tuln | grep ":21 ")   # 偵測看 port 21 在否？
if [ "$testing" != "" ]; then
	echo "FTP is running in your system."
fi
testing=$(netstat -tuln | grep ":25 ")   # 偵測看 port 25 在否？
if [ "$testing" != "" ]; then
	echo "Mail is running in your system."
fi
