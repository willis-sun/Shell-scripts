#!/bin/bash
#Create by willis. 2016-09-22
#
#这个脚本采用的iso是rhel-server-7.0-x86_64-dvd.iso，先将iso文件放置在/iso目录下，运行脚本即可


#############create  local  yumsoure ###########################
mount /iso/rhel-server-7.0-x86_64-dvd.iso  /mnt
rm -rf /etc/yum.repos.d/*

cat > /etc/yum.repos.d/yum.repo <<end
[yumsoure]
name=yumsoure
baseurl=file:///mnt
gpgcheck=0
end

yum clean all

###########create  share  server##########################

yum install httpd  -y
systemctl  stop  firewalld
systemctl  disable firewalld
systemctl  start   httpd
systemctl  enable  httpd

umount /mnt
mkdir -p  /var/www/html/yumsource
echo "/iso/rhel-server-7.0-x86_64-dvd.iso  /var/www/html/yumsource iso9660 defaults 0 0" >>/etc/fstab
mount -a

########### mode local yumsoure ########################
cat > /etc/yum.repos.d/yum.repo<<end
[yumsoure]
name=localhostsoucre
baseurl=file:///var/www/html/yumsource
gpgcheck=0
end




