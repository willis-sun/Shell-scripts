#!/bin/bash
#将密码文件与用户文件对应起来创建用户
#$1为用户文件,$2为密码文件
MAX=`wc -l $1|cut -d " " -f 1`
for NUM in $( seq 1 $MAX )
do
   NAME=`sed -n "$NUM"p $1`
   PASS=`sed -n "$NUM"p $2`
   useradd $NAME
   echo $PASS | passwd --stdin $NAME
done
