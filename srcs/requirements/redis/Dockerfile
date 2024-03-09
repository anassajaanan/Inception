FROM alpine:3.19.1

RUN apk update && apk add --no-cache redis

# Create a directory for Redis data
RUN mkdir -p /data && chown redis:redis /data

# Configure Redis to use the custom data directory and bind to all interfaces
RUN sed -i 's/^dir .*/dir \/data/' /etc/redis.conf \
    && sed -i 's/^bind 127.0.0.1 -::1/bind 0.0.0.0/' /etc/redis.conf

# Disable protected mode
RUN echo 'protected-mode no' >> /etc/redis.conf


EXPOSE 6379

# Run Redis server using the default configuration file
CMD ["redis-server", "/etc/redis.conf"]