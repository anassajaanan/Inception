FROM alpine:3.19.1

# Install PHP and extensions required by WordPress
RUN apk add --no-cache \
    php81-fpm \
    php81-json \
    php81-zlib \
    php81-xml \
    php81-pdo \
    php81-phar \
    php81-openssl \
    php81-pdo_mysql \
    php81-mysqli \
    php81-session \
    php81-gd \
    php81-iconv \
    php81-gmp \
    php81-zip \
    php81-curl \
    php81-opcache \
    php81-ctype \
    php81-intl \
    php81-bcmath \
    php81-dom \
    php81-mbstring \
    php81-xmlreader \
    mysql-client \
    curl \
    bash \
	netcat-openbsd \
    && apk add -u musl \
    && rm -rf /var/cache/apk/* \
    && ln -s /usr/bin/php81 /usr/bin/php


# Create the /var/www/html directory
RUN mkdir -p /var/www/html
WORKDIR /var/www/html


# Improve security by changing the default PHP settings
RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php81/php.ini && \
    sed -i 's/expose_php = On/expose_php = Off/g' /etc/php81/php.ini

#configure php-fpm
ADD conf/php-fpm.conf /etc/php81/
ADD tools/run.sh /
RUN chmod +x /run.sh

# Install WP-CLI
RUN adduser -S www-data -G www-data \
	&& curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/bin/wp \
    && chown www-data:www-data /usr/bin/wp

# Expose the port for PHP-FPM
EXPOSE 9000

CMD [ "/run.sh" ]