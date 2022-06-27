#!/bin/sh
mysql_install_db --user=mysql
chown -R mysql:mysql /data

/usr/bin/mysqld --user=mysql --bootstrap << EOF

create database if not exists $MARIADB_DATABASE;
flush privileges;
create user '$MARIADB_ADMIN_USER'@'$MARIADB_TARGET_HOST' identified by '$MARIADB_ADMIN_PASSWORD';
grant all privileges on wordpress.* to '$MARIADB_ADMIN_USER'@'$MARIADB_TARGET_HOST' identified by '$MARIADB_ADMIN_PASSWORD';
flush privileges;

set password for 'root'@'localhost' = password('$MARIADB_ROOT_PASSWORD');

EOF

# unset $MARIADB_DATABASE
# unset $MARIADB_ADMIN_USER
# unset $MARIADB_ADMIN_PASSWORD
# unset $MARIADB_ROOT_PASSWORD
# unset $MARIADB_TARGET_HOST

nc $MARIADB_TARGET_HOST 99 << EOF
done
EOF

exec /usr/bin/mysqld