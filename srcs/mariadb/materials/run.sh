#!/bin/sh

mv /materials/mariadb-server.cnf /etc/my.cnf.d/

mysql_install_db --user=mysql
chown -R mysql:mysql /data

/usr/bin/mysqld --user=mysql --bootstrap << EOF

create database if not exists $MARIADB_DATABASE;
flush privileges;

create user '$MARIADB_GENERAL_USER'@'localhost' identified by '$MARIADB_GENERAL_PASSWORD';
create user '$MARIADB_ADMIN_USER'@'localhost' identified by '$MARIADB_ADMIN_PASSWORD';
create user '$MARIADB_GENERAL_USER'@'$MARIADB_TARGET_HOST' identified by '$MARIADB_GENERAL_PASSWORD';
create user '$MARIADB_ADMIN_USER'@'$MARIADB_TARGET_HOST' identified by '$MARIADB_ADMIN_PASSWORD';

grant all privileges on wordpress.* to '$MARIADB_ADMIN_USER'@'$MARIADB_TARGET_HOST' identified by '$MARIADB_ADMIN_PASSWORD';
grant all privileges on wordpress.* to '$MARIADB_GENERAL_USER'@'$MARIADB_TARGET_HOST' identified by '$MARIADB_GENERAL_PASSWORD';
grant all privileges on wordpress.* to '$MARIADB_ADMIN_USER'@'localhost' identified by '$MARIADB_ADMIN_PASSWORD';
grant all privileges on wordpress.* to '$MARIADB_GENERAL_USER'@'localhost' identified by '$MARIADB_GENERAL_PASSWORD';

alter user 'root'@'localhost' identified by '$MARIADB_ROOT_PASSWORD' ;

flush privileges;

EOF

exec /usr/bin/mysqld