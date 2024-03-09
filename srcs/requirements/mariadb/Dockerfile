FROM alpine:3.19.1

RUN apk add --no-cache mariadb mariadb-client mariadb-server-utils pwgen && \
    rm -f /var/cache/apk/*

ADD tools/run.sh /
RUN chmod +x /run.sh

RUN mkdir /docker-entrypoint-initdb.d && \
    mkdir /scripts/ && mkdir /scripts/pre-exec.d && \
    mkdir /scripts/pre-init.d

EXPOSE 3306

ENTRYPOINT ["/run.sh"]