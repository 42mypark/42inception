#!/bin/sh

mv /materials/www.conf /etc/php8/php-fpm.d/

CONFIG="/var/www/html/wp-config.php"

if [ -f $CONFIG ]; then
	rm $CONFIG
fi;

COUNT=0;
$( nc -zv ${WORDPRESS_DB_HOST} 3306 );
until [ $? -eq 0 ]
do
	sleep 10;
	if [ $COUNT -eq 6 ]
	then
		exit 1;
	fi
	COUNT=$((COUNT+1))
	$( nc -zv ${WORDPRESS_DB_HOST} 3306 );
done;

wp core config --path=/var/www/html \
        --dbhost=${WORDPRESS_DB_HOST} \
        --dbname=${WORDPRESS_DB_NAME} \
        --dbuser=${WORDPRESS_DB_USER} \
        --dbpass=${WORDPRESS_DB_PASS} \
        --locale=${WORDPRESS_LOCALE} \
        --skip-check &&\
wp core install --path=/var/www/html \
		--url=${WORDPRESS_WEBSITE_URL_NOHTTP} \
		--title=${WORDPRESS_WEBSITE_TITLE} \
		--admin_user=${WORDPRESS_ADMIN_USER} \
		--admin_password=${WORDPRESS_ADMIN_PASS} \
		--admin_email=${WORDPRESS_ADMIN_EMAIL};

wp plugin --path=/var/www/html install wp-redis;
wp plugin --path=/var/www/html activate wp-redis;

wp user create --path=/var/www/html ${WORDPRESS_GENERAL_USER} ${WORDPRESS_GENERAL_EMAIL} --user_pass=${WORDPRESS_GENERAL_PASS}

echo "define('WP_REDIS_HOST', '${WORDPRESS_REDIS_HOST}' );" >> /var/www/html/wp-config.php
echo "define('WP_REDIS_PORT', '${WORDPRESS_REDIS_PORT}' );" >> /var/www/html/wp-config.php

exec /usr/sbin/php-fpm8 -F -R -O
