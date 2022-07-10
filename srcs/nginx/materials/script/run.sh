#!/bin/sh
mv /materials/conf/default.conf /etc/nginx/http.d/
mv /materials/conf/nginx.conf /etc/nginx/
sh /materials/script/ssl.sh "localhost";
exec /usr/sbin/nginx -g "daemon off;";
