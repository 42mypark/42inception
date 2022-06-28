#!/bin/sh
sh /script/ssl.sh localhost
exec /usr/sbin/nginx -g "daemon off;"