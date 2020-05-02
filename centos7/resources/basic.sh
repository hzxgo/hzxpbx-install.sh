#!/bin/sh

#move to script directory so all relative paths work
cd "$(dirname "$0")"

#includes
. ./config.sh
. ./colors.sh

#send a message
verbose "basic.sh install starting..."
verbose "Update yum and install basic packages"

yum -y update && yum -y upgrade

# Add additional repository
yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm

# Installing basics packages
yum -y install ntp yum-utils net-tools epel-release htop vim openssl
yum -y install git gcc-c++ autoconf automake libtool wget python ncurses-devel libevent libevent-devel
yum -y install zlib-devel libjpeg-devel openssl-devel e2fsprogs-devel sqlite-devel lua-devel libpq-devel
yum -y install curl-devel libcurl-devel pcre pcre-devel speex speex-devel ldns-devel libedit-devel 
yum -y install memcached libmemcached-devel postgresql-devel libsndfile-devel
yum -y install ghostscript libtiff-devel libtiff-tools at

wget https://hzxgo.oss-cn-shanghai.aliyuncs.com/file/cert-forensics-tools-release-el7.rpm
rpm -Uvh cert-forensics-tools-release*rpm
yum -y --enablerepo=forensics install lame

# add user
useradd freeswitch -g daemon -s /sbin/nologin -M

verbose "basic.sh install end"