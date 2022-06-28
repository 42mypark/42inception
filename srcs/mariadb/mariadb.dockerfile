FROM alpine:3.16
RUN apk add --no-cache mariadb mariadb-client mariadb-server-utils
RUN mkdir -p /run/mysqld &&\
	mkdir -p /var/lib/mysql/mysql &&\
	chown -R mysql:mysql /run/mysqld &&\
	chown -R mysql:mysql /var/lib/mysql
COPY ./mariadb-server.cnf /etc/my.cnf.d/
COPY ./run.sh /run.sh
EXPOSE 3306
ENTRYPOINT [ "/run.sh" ]

