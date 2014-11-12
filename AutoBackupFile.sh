#!/bin/bash
#Author mogu
#Time 12/11/14
#This script for the backup /file directory

#这两个目录用于存放不同的磁盘备份
#这个脚本没有使用变量"BACKUP_FILE_DIR_2"
BACKUP_FILE_DIR_1="/mnt/backup/file"
BACKUP_FILE_DIR_2="/mnt/backup_file"

#定义存放备份文件的名称的变量
#backup_file name
BACKUP_FILE_NAME=null

#定义存放日志的文件
#Log file directory
LOG_FILE="/root/file_backup.log"

#定义相应的变量,分别存放当前年,月,日,时,分,周
#可以使用这些变量拓展脚本的功能

#date
YEAR=`date +%Y`
MOUNTH=`date +%m`
DAY=`date +%d`
HOUR=`date +%k`
MINUTE=`date +%M`
WEEK=`date +%w`

#定义完全备份函数backup_full,需要使用tar 命令备份参数指定的目录,并根据tar命令的退出状态设置函数的返回状态
#函数使用了两个参数,分别是要备份的目录,存放备份文件的路径和名称
#Backup type:full
function backup_full()
{
    #保存当前目录到变量DIR中
    DIR=`pwd`
    #使用命令dirname获取目标目录的上级目录
    _DIR=`dirname $1`
    #获取要备份的目录名称
    BACKUP_DIR=`basename $1`

    #进入备份目录的上级目录开始备份
    cd $_DIR
    tar -czf $2 $BACKUP_DIR &>/dev/null
    
    #如果备份成功,则返回原目录,清除变量并返回
    if [ $? = 0 ]
    then
        cd $DIR
        unset DIR _DIR BACKUP_DIR
        return 0
    else
        #如果备份失败,则返回原目录,清除使用的变量,返回函数状态为失败
        cd $DIR
        unset DIR _DIR BACKUP_DIR
        return 1
    fi
}

#定义差异备份模块
#在差异备份模块中,需要先使用find命令和参数查找需要备份的文件,并保存在临时文件中.最后再使用tar命令备份临时文件中列出的文件,并根据命令的退出状态设置函数的返回状态.
#开始定义差异备份使用的函数backup_incremental
#函数使用3个参数,分别是要备份的目录,时间,存放备份文件的路径和名称
#时间参数使用的单位是天
#backup_incremental
function backup_incremental ()
{
    #保存当前目录到变量DIR中
    DIR=`pwd`
    #保存目标目录的上级目录
    _DIR=`dirname $1`
    #保存要备份的目录名称
    BACKUP_DIR=`basename $1`

    #进入需要备份目录的上级目录
    cd $_DIR
    #使用find 命令查找需要备份的文件,这些文件满足两个条件
    #第1,文件类型为普通文件
    #第2,文件的修改时间戳记在指定的时间以内
    #将找到的文件放入临时文件/tmp/backup_file_list中
    find ./$BACKUP_DIR -type f -mtime -$2 -print >/tmp/backup_file_list 2>/dev/null
    if [ $? = 0 ]
    then
        #如果find 命令执行成功,则使用tar命令备份找到的文件
        tar -czT /tmp/backup_file_list -f $3 &>/dev/null
        #如果tar命令备份文件成功,则清除变量,删除临时文件并返回
        if [ $? = 0 ]
        then
            unset DIR _DIR BACKUP_DIR
            rm -rf /tmp/backup_file_list &>/dev/null
            return 0
         #如果tar命令执行失败,清除变量,删除临时文件并返回
        else
            unset DIR _DIR BACKUP_DIR
            rm -rf /tmp/backup_file_list &>/dev/null
            return 1
        fi
    else
        #find 命令执行失败时,清除变量,删除可能的临时文件,然后返回
        unset DIR _DIR BACKUP_DIR
        rm -rf /tmp/backup_file_list &>/dev/null
        return 1
    fi
}
#由于使用时间戳记作为文件更新标记,因此函数中实现的是差异备份,还是增量备份都依赖于函数收到的时间参数

#远程备份模块
#远程备份模块流程是先挂载远程文件系统,然后备份文件复制到远程文件系统中,最后卸载远程文件系统.

#定义用于上传备份文件的函数backup_nfs
#函数使用远程服务器的nfs目标作为目标目录,将备份文件上传到远程服务器
#函数使用备份文件的名称作为参数
#function backup_nfs
#upload backup file
function backup_nfs ()
{
    #使用mount 命令将远程服务器的nfs目录挂载到本地的/mnt/nfs目录中
    #此处假定本地用于挂载的目录已经存在
    mount -t nfs 192.168.118.226:/mnt/backup /mnt/nfs &>/dev/null
    if [ $? = 0 ]
    then
        #如果挂载命令执行成功,则将参数指定的文件使用cp命令上传到远程服务器
        if `cp $1 /mnt/nfs`
        then
            echo "Upload successful." >>$LOG_FILE
            umount /mnt/nfs
            return 0
        else
        #如果上传失败,则输出提示到日志文件,卸载远程文件系统并返回
            echo "Upload failed!" >>$KOG_FILE
            umount /mnt/nfs
            return 1
        fi
    else
        #如果挂载远程文件系统失败,则输出提示到日志文件并返回
        echo "mount nfs failed!" >>$LOG_FILE
        return 1
    fi
}

#以下是主体和日志功能,会调用上面定义的变量和函数
#该模块是先判断脚本运行时间是否为星期天,如果是则调用完全备份函数,否则就调用差异备份函数.在整个主体结构中,按函数的执行状态设置日志.

#判断当前是否为星期天,如果是则使用完全备份
#if it is sunday
#use function backup_full
if [ $WEEK = 0 ]
then
    #定义备份之后备份文件名称并保存在BACKUP_FILE_NAME变量中
    BACKUP_FILE_NAME="$BACKUP_FILE_DIR_1/$YEAR-$MOUNTH-$DAY-$HOUR-$MINUTE.full.tar.gz"
    #调用backup_full函数对目录/file/soft执行完全备份
    backup_full "file/soft" "$BACKUP_FILE_NAME"

    #判断backup_full函数是否执行失败
    if [ $? != 0 ]
    then
        #如果完全备份失败,就向日志文件写入备份开始信息
        echo "#################Backup begin#####################">>$LOG_FILE
        #将当前时间写入日志文件
        echo "time:$YEAR-$MOUNTH-$DAY $HOUR:$MINUTE">>$LOG_FILE
        #向日志文件写入备份错误以及备份结束信息
        echo "backup error.">>$LOG_FILE
        echo "#######################End#####################">>$LOG_FILE
        #清除所有使用过的变量,函数并设置退出状态
        unset BACKUP_FILE_DIR_1 BACKUP_FILE_DIR_2 BACKUP_FILE_NAME LOG_FILE
        unset YEAR MOUNTH DAY HOUR MINUTE WEEK
        unset backup_full backup_incremental backup_nfs
        exit 1
    fi
    #如果backup_full函数执行成功,就向日志文件写入备份开始,备份时间,备份成功信息
    echo "###########################Backup begin################">>$LOG_FILE
    echo "time:%YEAR-%MOUNTH-%DAY %HOUR:%MINUTE">>$LOG_FILE
    echo "backup successful.">>$LOG_FILE
    #调用backup_nfs函数将备份文件上传到远程服务器
    backup_nfs $BACKUP_FILE_NAME
    #如果上传备份文件函数执行失败
    #就输出结束信息到日志文件,清除使用过的变量函数并设置退出状态
    if [ $? != 0 ]
    then
        echo "######################End###########################">>$LOG_FILE
        unset BACKUP_FILE_DIR_1 BACKUP_FILE_DIR_2 BACKUP_FILE_NAME LOG_FILE
        unset YEAR MOUNTH DAY HOUR MINUTE WEEK
        unset backup_full backup_incremental backup_nfs
        exit 1
    fi

    #如果上传成功,则输出结束信息到日志文件,清除变量函数并设置退出状态
    echo "##########################End###########################">>$LOG_FILE
    unset BACKUP_FILE_DIR_1 BACKUP_FILE_DIR_2 BACKUP_FILE_NAME LOG_FILE
    unset YEAR MOUNTH DAY HOUR MINUTE WEEK
    unset backup_full backup_incremental backup_nfs
    exit 0
fi

#如果不是星期天,就使用差异备份
#if not sunday
#use function backup_incremental
#将备份文件保存到变量BACKUP_FILE_NAME中
BACKUP_FILE_NAME="$BACKUP_FILE_DIR_1/$YEAR-$MOUNTH-$DAY-$HOUR-$MINUTE.incremental.tar.gz"
#调用backup_incremental函数对目录/file/soft执行差异备份,时间参数设置为1天
backup_incremental "/file/soft" "1" "$BACKUP_FILE_NAME"

#判断backup_incremental函数执行是否失败
if [ $? != 0 ]
then
    #如果执行失败,就将开始信息,时间,错误信息和结束信息写入到日志文件
    echo "########################Backup begin#####################">>$LOG_FILE
    echo "time:$YEAR-$MOUNTH-$DAY $HOUR:$MINUTE">>$LOG_FILE
    echo "backup error.">>$LOG_FILE
    echo "########################End##############################">>$LOG_FILE
    #清除使用过的变量,函数并设置退出状态
    unset BACKUP_FILE_DIR_1 BACKUP_FILE_DIR_2 BACKUP_FILE_NAME LOG_FILE        
    unset YEAR MOUNTH DAY HOUR MINUTE WEEK                                     
    unset backup_full backup_incremental backup_nfs
    exit 1
fi

#如果执行成功,则调用函数backup_nfs将备份文件上传到远程服务器
backup_nfs $BACKUP_FILE_NAME

#如果函数执行失败,就将信息写入日志文件,清除变量函数并设置退出状态
if [ $? != 0 ]
then
    echo "#########################End############################">>$LOG_FILE
    unset BACKUP_FILE_DIR_1 BACKUP_FILE_DIR_2 BACKUP_FILE_NAME LOG_FILE        
    unset YEAR MOUNTH DAY HOUR MINUTE WEEK                                     
    unset backup_full backup_incremental backup_nfs
    exit 1
fi
#如果上传函数执行成功,就将结束信息写入日志文件,清除使用过的变量并设置退出状态
echo "#############################End############################">>$LOG_FILE
unset BACKUP_FILE_DIR_1 BACKUP_FILE_DIR_2 BACKUP_FILE_NAME LOG_FILE        
unset YEAR MOUNTH DAY HOUR MINUTE WEEK                                     
unset backup_full backup_incremental backup_nfs
exit 0

#自动运行备份脚本的实现
#为了实现自动备份功能,需要就爱那个备份脚本加入到计划任务中
#运行命令crontab -e打开计划任务编辑窗口,然后在其中输入以下内容:   * 3 *** /root/backup_file.sh
#保存之后,系统就会在每天凌晨3点开始备份数据了.
