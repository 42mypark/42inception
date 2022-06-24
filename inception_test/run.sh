#!/bin/sh
mysql_install_db --user=mysql
chown -R mysql:mysql /data
exec /usr/bin/mysqld
