#!/bin/sh
IP=$(ip address | grep -e ".*\.*\..*\..*/* enp*" | awk '{print $2;}' | sed 's/\/.*//');
sed -i "s#localhost#${IP}#g" srcs/php-fpm/.php-fpm.env;
sed -i "s#localhost#${IP}#g" srcs/nginx/default.conf;
sed -i "s#localhost#${IP}#g" srcs/nginx/script/run.sh;
