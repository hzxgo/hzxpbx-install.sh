#!/bin/sh

# CentOS 7 install

# move to script directory so all relative paths work
cd "$(dirname "$0")"

#includes
. ./resources/config.sh
. ./resources/colors.sh

# Update CentOS 
verbose "Begin to install hzxpbx At CentOS7"

# Install basic packages
resources/basic.sh
 
# Disable SELinux
resources/selinux.sh

# FusionPBX
resources/fusionpbx.sh

# Postgres
resources/postgresql.sh

# NGINX web server
resources/sslcert.sh
resources/nginx.sh

# PHP/PHP-FPM
resources/php.sh

# Firewalld
resources/firewalld.sh

# FreeSWITCH
resources/switch.sh

# Fail2ban
resources/fail2ban.sh

# Redis
resources/redis.sh

# phpredis
resources/phpredis.sh

#restart services
verbose "Restarting packages for final configuration"
systemctl daemon-reload
systemctl restart freeswitch
systemctl restart php-fpm
systemctl restart nginx
systemctl restart fail2ban

#add the database schema, user and groups
resources/finish.sh

# 关闭fail2ban
systemctl stop fail2ban

# 安装后最好重启
# reboot
