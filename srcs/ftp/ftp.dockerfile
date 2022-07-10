FROM alpine:3.16
RUN apk add vsftpd &&\
	mkdir -p /var/log/vsftpd
COPY ./materials /materials
EXPOSE 20 21
STOPSIGNAL SIGKILL
ENTRYPOINT [ "/materials/run.sh" ]