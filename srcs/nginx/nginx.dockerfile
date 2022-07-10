FROM alpine:3.16
RUN apk add --no-cache nginx openssl && mkdir -p /script
COPY ./materials/ /materials/
EXPOSE 443/tcp
ENTRYPOINT ["/materials/script/run.sh"]
