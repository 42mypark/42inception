#!/bin/sh
sh /script/ssl.sh "10.11.250.154";
exec /usr/sbin/nginx -g "daemon off;";
