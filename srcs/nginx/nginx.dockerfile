FROM alpine:3.16
RUN apk add --no-cache nginx
COPY ./default.conf /etc/nginx/http.d/
COPY ./nginx.conf /etc/nginx/
EXPOSE 443/tcp
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]
