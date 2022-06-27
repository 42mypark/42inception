FROM alpine:3.16
RUN apk add --no-cache php8-fpm php8 php8-mysqli php8-phar php8-openssl php8-mbstring curl mysql mysql-client
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar &&\
	chmod +x wp-cli.phar &&\
	mv wp-cli.phar /usr/local/bin/wp
# RUN /usr/local/bin/wp cli update
EXPOSE 9000/tcp
EXPOSE 99
# COPY ./php-fpm/index.php /var/www/html/
COPY ./www.conf /etc/php8/php-fpm.d/
COPY ./run.sh /run.sh
ENTRYPOINT ["/run.sh"]
