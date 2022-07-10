#!/bin/sh
IP=$(ip address | grep -e ".*\.*\..*\..*/* enp*" | awk '{print $2;}' | sed 's/\/.*//');
sed -i "s#${IP}#localhost#g" srcs/php-fpm/.php-fpm.env;
sed -i "s#${IP}#localhost#g" srcs/nginx/materials/conf/default.conf;
sed -i "s#${IP}#localhost#g" srcs/nginx/materials/script/run.sh;
