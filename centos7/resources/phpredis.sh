#!/bin/sh

#move to script directory so all relative paths work
cd "$(dirname "$0")"
cwd=$(pwd)

#includes
. ./config.sh
. ./colors.sh

#send a message
verbose "Installing php-redis"

cd phpredis
tar -zxvf phpredis-4.0.2.tar.gz
cd phpredis-4.0.2
/usr/bin/phpize
./configure --with-php-config=/usr/bin/php-config
make && make install
echo 'extension=redis.so' >> /etc/php.ini

cd ..
rm -rf phpredis-4.0.2

systemctl restart php-fpm

cd $cwd

#send a message
verbose "php_redis 4.0.2 installed"