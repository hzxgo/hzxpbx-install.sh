#!/bin/sh

#install git
yum -y install git

#get the install script
cd /usr/src && git clone https://github.com/hzxgo/fusionpbx-install.git

#change the working directory
cd /usr/src/fusionpbx-install/centos
