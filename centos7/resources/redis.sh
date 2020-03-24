#!/bin/sh

#move to script directory so all relative paths work
cd "$(dirname "$0")"
cwd=$(pwd)

#includes
. ./config.sh
. ./colors.sh

#send a message
verbose "Installing redis"

# install gcc
yum -y install gcc

# install redis
cd ./redis
wget https://hzxgo.oss-cn-shanghai.aliyuncs.com/file/redis-4.0.11.tar.gz
tar -xzvf redis-4.0.11.tar.gz
cd redis-4.0.11
make
make install

# set conf
cd ..
mkdir /etc/redis
cp -f redis.conf /etc/redis/
cp -f redis.service /usr/lib/systemd/system/redis.service

systemctl daemon-reload
systemctl start redis
systemctl enable redis

# del 
rm -rf redis-4.0.11

cd $cwd

#send a message
verbose "redis 4.0.2 installed"