FROM alpine:3.19.1

WORKDIR /etc/nginx

RUN apk update && apk add --no-cache nginx openssl

RUN mkdir /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.crt \
    -subj "/C=US/ST=State/L=AbuDhabi/O=42/CN=localhost"


COPY conf/nginx.conf /etc/nginx/http.d/default.conf

EXPOSE 443

CMD nginx -g "daemon off;"