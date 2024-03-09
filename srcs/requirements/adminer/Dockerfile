FROM alpine:3.19.1

RUN	addgroup -S adminer \
&&	adduser -S -G adminer adminer \
&&	mkdir -p /var/www/html \
&&	mkdir /var/www/html/plugins-enabled \
&&	chown -R adminer:adminer /var/www/html

WORKDIR /var/www/html

# Install PHP and extensions required by Adminer
RUN apk add --no-cache \
    php81 \
    php81-fpm \
    php81-session \
    php81-mysqli \
    php81-json \
    php81-openssl \
    php81-curl \
    php81-zlib \
    php81-xml \
    php81-phar \
    php81-intl \
    php81-dom \
    php81-xmlreader \
    php81-ctype \
    php81-mbstring \
    curl


# Download Adminer
ENV	ADMINER_VERSION 4.8.1
RUN curl -fsSL "https://github.com/vrana/adminer/releases/download/v$ADMINER_VERSION/adminer-$ADMINER_VERSION.php" -o adminer.php

# Configure PHP-FPM
ADD conf/php-fpm.conf /etc/php81/


# Expose the port for PHP-FPM
EXPOSE 8080


CMD [ "php-fpm81", "-F" ]
