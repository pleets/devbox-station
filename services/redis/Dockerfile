FROM redis:7.0

# Copy configuration
COPY redis.conf /usr/local/etc/redis/redis.conf

# Run the redis server
CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]
