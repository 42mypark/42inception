FROM alpine:3.16
RUN apk add --no-cache php-fpm php php-mysqli
EXPOSE 9000/tcp
# COPY ./php-fpm/index.php /var/www/html/
COPY ./php-fpm/www.conf /etc/php8/php-fpm.d/
ENTRYPOINT ["/usr/sbin/php-fpm8", "-F", "-R", "-O"]