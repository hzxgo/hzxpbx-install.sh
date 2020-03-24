#!/bin/sh

verbose "Begin to install FreeSWITCH"

# 启动并设置开机启动
systemctl start memcached
systemctl enable memcached

# 安装yasm
verbose "install yasm begin"
cd /usr/local/src/
rm -rf yasm-1.3.0*
wget https://hzxgo.oss-cn-shanghai.aliyuncs.com/file/yasm-1.3.0.tar.gz
tar zxf yasm-1.3.0.tar.gz
cd yasm-1.3.0
./configure
make
make install
verbose "install yasm end"

# 安装opus
verbose "install opus begin"
cd /usr/local/src/
rm -rf opus*
wget https://hzxgo.oss-cn-shanghai.aliyuncs.com/file/opus.tar.bz2
tar xjf opus.tar.bz2
cd opus
./autogen.sh
./configure
make
make install
cp -f /usr/local/lib/pkgconfig/opus.pc /usr/lib64/pkgconfig/
verbose "install opus end"

# 安装mod_shout依赖文件，还需要安装lame，参考basic.sh
verbose "install mod_shout req begin"
cd /usr/local/src/
wget https://hzxgo.oss-cn-shanghai.aliyuncs.com/file/libshout-2.2.2-11.el7.x86_64.rpm
wget https://hzxgo.oss-cn-shanghai.aliyuncs.com/file/libshout-devel-2.2.2-11.el7.x86_64.rpm
yum -y install libshout-devel lame-devel libmpg123-devel
rpm -Uvh libshout-2.2.2-11.el7.x86_64.rpm
rpm -Uvh libshout-devel-2.2.2-11.el7.x86_64.rpm
verbose "install mod_shout req end"

# 安装freeswitch
verbose "install freeswitch by source start"
cd /usr/local/src/
wget https://hzxgo.oss-cn-shanghai.aliyuncs.com/file/freeswitch-v1.6.20.tar.bz2
tar xjf freeswitch-v1.6.20.tar.bz2
cd freeswitch
./bootstrap.sh -j
rm -rf modules.conf
wget https://hzxgo.oss-cn-shanghai.aliyuncs.com/file/modules.conf
./configure --enable-portable-binary \
            --prefix=/usr --localstatedir=/var --sysconfdir=/etc \
            --with-gnu-ld --with-python --with-erlang --with-openssl \
            --enable-core-pgsql-support --enable-core-odbc-support --enable-zrtp

./configure --prefix=/usr --localstatedir=/var --sysconfdir=/etc --enable-core-pgsql-support
make
make install
verbose "install freeswitch by source end"

# 安装语音文件
wget https://hzxgo.oss-cn-shanghai.aliyuncs.com/file/fs_sounds_en_zh_8000.tar.bz2
tar xjf fs_sounds_en_zh_8000.tar.bz2
cp -rf sounds /usr/share/freeswitch/sounds


./configure --prefix=/usr --localstatedir=/var --sysconfdir=/etc
make mod_shout-install









