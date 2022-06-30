#!/bin/sh
IP=$(ip address | grep -e ".*\.*\..*\..*/* enp0s3" | awk '{print $2;}' | sed 's/\/.*//');
sed -i "s#localhost#${IP}#g" srcs/php-fpm/.php-fpm.env;