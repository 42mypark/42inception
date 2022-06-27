#!/bin/sh

CONFIG="/var/www/html/wp-config.php"

if [ -f $CONFIG ]; then
	rm $CONFIG
fi;

nc -l localhost 3000 |

while read -r cmd; do
	echo $cmd;
  case $cmd in
    done) break;;
    *) ;;
  esac
done

kill "$COPROC_PID"

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

unset WORDPRESS_DB_NAME;
unset WORDPRESS_DB_USER;
unset WORDPRESS_DB_PASS;
unset WORDPRESS_DB_HOST;
unset WORDPRESS_WEBSITE_TITLE;
unset WORDPRESS_WEBSITE_URL_NOHTTP;
unset WORDPRESS_ADMIN_EMAIL;
unset WORDPRESS_ADMIN_PASS;
unset WORDPRESS_ADMIN_USER;

exec /usr/sbin/php-fpm8 -F -R -O