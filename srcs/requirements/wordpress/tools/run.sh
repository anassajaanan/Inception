#!/bin/sh

# ===============================================
# Waiting for MariaDB to be ready
# ===============================================
while ! mysqladmin ping -h"$DB_HOST" --silent; do
    echo "Waiting for MariaDB to become ready..."
    sleep 1
done
echo "MariaDB is ready."


# ===============================================
# Starting WordPress setup
# ===============================================
echo "Starting WordPress setup..."

# Ensure the target directory exists
echo "Ensuring the WordPress directory exists at /var/www/html/wordpress..."
mkdir -p /var/www/html/wordpress


# ===============================================
# Check if WordPress is already installed
# ===============================================
if ! wp core is-installed --path=/var/www/html/wordpress --allow-root 2>/dev/null; then
    echo "WordPress not found. Proceeding with installation..."
    
	# ===============================================
	# Downloading WordPress
	# ===============================================
    echo "Downloading WordPress..."
    wp core download --path=/var/www/html/wordpress --allow-root
    if [ $? -eq 0 ]; then
        echo "WordPress downloaded successfully."
    else
        echo "Error downloading WordPress."
        exit 1
    fi
    
	# ===============================================
	# Creating wp-config.php
	# ===============================================
    echo "Creating wp-config.php file..."
    wp config create --dbname="${WP_DB_NAME}" --dbuser="${WP_DB_USER}" --dbpass="${WP_DB_PASSWORD}" --dbhost="${DB_HOST}" --path=/var/www/html/wordpress --allow-root
    if [ $? -eq 0 ]; then
        echo "wp-config.php created successfully."
    else
        echo "Error creating wp-config.php."
        exit 1
    fi

	# ===============================================
	# Installing WordPress
	# ===============================================
    echo "Installing WordPress..."
    wp core install --url="https://localhost/" --title="Anas Ajaanan" --admin_user="${WP_ADMIN_USER}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}" --path=/var/www/html/wordpress --allow-root
    if [ $? -eq 0 ]; then
        echo "WordPress installed successfully."
    else
        echo "Error installing WordPress."
        exit 1
    fi
else
    echo "WordPress is already installed."
fi

# ===============================================
# Wait for Redis to be ready
# ===============================================
echo "Waiting for Redis..."
until nc -z redis 6379; do
    sleep 1
    echo "Redis is not up yet..."
done
echo "Redis is up!"

# ================================================================
# Configure Redis: Dynamically set the Redis host in wp-config.php
# ================================================================

echo "Configuring Redis in wp-config.php..."
WP_CONFIG_PATH="/var/www/html/wordpress/wp-config.php"
if grep -q "WP_REDIS_HOST" "$WP_CONFIG_PATH"; then
    echo "Redis host already defined."
else
    sed -i "/\/\* That's all, stop editing! Happy publishing. \*\//i define('WP_REDIS_HOST', 'redis');" $WP_CONFIG_PATH
    echo "Added Redis host definition."
fi

# ===============================================
# Install and activate Redis Object Cache plugin
# ===============================================
echo "Installing and activating Redis Object Cache plugin..."
wp plugin install redis-cache --activate --allow-root --path=/var/www/html/wordpress
wp redis enable --allow-root --path=/var/www/html/wordpress


# ===============================================
# Adjusting permissions
# ===============================================
echo "Adjusting permissions..."
chown -R www-data:www-data /var/www/html/wordpress
chmod -R 755 /var/www/html/wordpress


# ===============================================
# Start PHP-FPM
# ===============================================
echo "WordPress setup complete. Starting wp's PHP-FPM..."
exec php-fpm81 -F
