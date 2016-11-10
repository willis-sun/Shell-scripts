#!/bin/bash
#
#监控磁盘，找出指定目录的前若干个磁盘使用最大的目录
##################################
CHECK_DIRECTORIES="/var/log /home"
########## Main Scripts ##########
DATE=$(date '+%Y%m%d')
exec > disk1_space_$DATE.rpt   #Make report files Std Output
echo "Top Ten Disk Space Usage"
echo "for $CHECK_DIRECTORIES Directories"

for DIR_CHECK in $CHECK_DIRECTORIES
do
    echo ""
    echo "The $DIR_CHECK Directories:"

     du -S $DIR_CHECK 2>/dev/null | sort -rn | sed '{11,$D; =}' | sed 'N; s/\n/ /' | gawk '{print $2 ":" "\t" $2 "\t" $3 "\n"}'
#    du -S $DIR_CHECK 2>/dev/null |sort -rn |head -10
done
