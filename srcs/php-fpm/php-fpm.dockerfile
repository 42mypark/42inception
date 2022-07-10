FROM alpine:3.16
RUN apk add --no-cache php8-fpm php8 php8-mysqli php8-phar php8-openssl php8-mbstring php8-gettext php8-session curl mysql mysql-client
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar &&\
	chmod +x wp-cli.phar &&\
	mv wp-cli.phar /usr/local/bin/wp
EXPOSE 9000/tcp 6379/tcp
COPY ./materials /materials
ENTRYPOINT ["/materials/run.sh"]
