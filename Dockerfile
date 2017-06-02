# build stage
FROM golang:alpine AS build-env

RUN go get -v github.com/mholt/caddy/caddy
#TODO Build with locale and search plugin

FROM alpine:edge
EXPOSE 80

RUN apk add --no-cache wget mailcap ca-certificates
COPY --from=build-env /go/bin/caddy /usr/sbin/caddy

CMD ["/usr/sbin/caddy", "-conf", "/etc/caddy.conf"]

COPY docker/caddy.conf /etc/caddy.conf
COPY public /srv/www
