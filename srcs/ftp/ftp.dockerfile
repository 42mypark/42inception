FROM alpine:3.16
RUN apk add vsftpd &&\
	mkdir -p /var/log/vsftpd
COPY ./vsftpd.conf /etc/vsftpd/
COPY ./run.sh /run.sh
EXPOSE 20 21
STOPSIGNAL SIGKILL
ENTRYPOINT [ "/run.sh" ]