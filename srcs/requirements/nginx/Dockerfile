FROM alpine:3.16
RUN apk add nginx
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]
EXPOSE 80/tcp
