FROM alpine:3.16
RUN apk add --no-cache nginx openssl && mkdir -p /script
COPY ./default.conf /etc/nginx/http.d/
COPY ./nginx.conf /etc/nginx/
COPY ./script/ /script/
EXPOSE 443/tcp
ENTRYPOINT ["/script/run.sh"]
