#!/bin/sh

#move to script directory so all relative paths work
cd "$(dirname "$0")"

#includes
. ../config.sh
. ../colors.sh

#send a message
verbose "Installing FreeSWITCH"

#install dependencies
yum -y install memcached curl gdb

# 安装yasm
verbose "install yasm begin"
wget https://hzxgo.oss-cn-shanghai.aliyuncs.com/file/yasm-1.3.0.tar.gz
tar zxf yasm-1.3.0.tar.gz
cd yasm-1.3.0
./configure
make
make install
rm -rf yasm-1.3.0*
verbose "install yasm end"

# 安装opus
verbose "install opus begin"
wget https://hzxgo.oss-cn-shanghai.aliyuncs.com/file/opus.tar.bz2
tar xjf opus.tar.bz2
cd opus
./autogen.sh
./configure
make
make install
cp -f /usr/local/lib/pkgconfig/opus.pc /usr/lib64/pkgconfig/
rm -rf opus*
verbose "install opus end"

# 安装mod_shout依赖文件，还需要安装lame，参考basic.sh
verbose "install mod_shout req begin"
wget https://hzxgo.oss-cn-shanghai.aliyuncs.com/file/libshout-2.2.2-11.el7.x86_64.rpm
wget https://hzxgo.oss-cn-shanghai.aliyuncs.com/file/libshout-devel-2.2.2-11.el7.x86_64.rpm
yum -y install libshout-devel lame-devel libmpg123-devel
rpm -Uvh libshout-2.2.2-11.el7.x86_64.rpm
rpm -Uvh libshout-devel-2.2.2-11.el7.x86_64.rpm
rm -rf libshout-2.2.2-11.el7.x86_64.rpm
rm -rf libshout-devel-2.2.2-11.el7.x86_64.rpm
verbose "install mod_shout req end"

verbose "install freeswitch-release-1-6 begin"
#install freeswitch packages
# yum install -y http://files.freeswitch.org/freeswitch-release-1-6.noarch.rpm
yum install -y https://hzxgo.oss-cn-shanghai.aliyuncs.com/file/freeswitch-release-1-6.noarch.rpm
#yum install -y freeswitch-config-vanilla freeswitch-lang-* freeswitch-sounds-* freeswitch-lua freeswitch-xml-cdr
yum install -y freeswitch-config-vanilla freeswitch-lang-en freeswitch-lua freeswitch-xml-cdr
verbose "install freeswitch-release-1-6 end"

#remove the music package to protect music on hold from package updates
#mkdir -p /usr/share/freeswitch/sounds/temp
#mv /usr/share/freeswitch/sounds/music/*000 /usr/share/freeswitch/sounds/temp
#yum -y remove freeswitch-sounds-music
#mkdir -p /usr/share/freeswitch/sounds/music/default
#mv /usr/share/freeswitch/sounds/temp/* /usr/share/freeswitch/sounds/music/default
#rm -R /usr/share/freeswitch/sounds/temp

# 下载已编译好的 mod_sya_zh
verbose "install freeswitch-mod_sya_zh begin"
wget https://hzxgo.oss-cn-shanghai.aliyuncs.com/file/fs1.6.20_mod_say_zh.tar.bz2
tar xjf fs1.6.20_mod_say_zh.tar.bz2
cp fs1.6.20_mod_say_zh/mod_say_zh.so /usr/lib64/freeswitch/mod/
rm -rf fs1.6.20_mod_say_zh*
verbose "install freeswitch-mod_sya_zh end"

# 下载已编译好的 mod_shout
verbose "install freeswitch-mod_shout begin"
wget https://hzxgo.oss-cn-shanghai.aliyuncs.com/file/fs1.6.20_mod_shout.tar.bz2
tar xjf fs1.6.20_mod_shout.tar.bz2
cp fs1.6.20_mod_shout/mod_shout.so /usr/lib64/freeswitch/mod/
rm -rf fs1.6.20_mod_shout*
verbose "install freeswitch-mod_shout end"

# 下载音频文件
wget https://hzxgo.oss-cn-shanghai.aliyuncs.com/file/fs_sounds_en_zh_8000.tar.bz2
tar xjf fs_sounds_en_zh_8000.tar.bz2
mv sounds /usr/share/freeswitch/sounds
rm -rf fs_sounds_en_zh_8000.tar.bz2

#send a message
verbose "FreeSWITCH installed"
