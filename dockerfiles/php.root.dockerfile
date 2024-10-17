FROM php:8.2-fpm-alpine3.18

# Create application directory
RUN mkdir -p /var/www/html

# Set the working directory
WORKDIR /var/www/html

# Update PHP-FPM configuration to run as root (not recommended for production)
RUN sed -i "s/user = www-data/user = root/g" /usr/local/etc/php-fpm.d/www.conf \
    && sed -i "s/group = www-data/group = root/g" /usr/local/etc/php-fpm.d/www.conf \
    && echo "php_admin_flag[log_errors] = on" >> /usr/local/etc/php-fpm.d/www.conf

# Install PDO and PDO MySQL extensions
RUN docker-php-ext-install pdo pdo_mysql

# Install GD extension
RUN apk add --no-cache libpng libpng-dev \
    && docker-php-ext-configure gd --enable-gd --with-jpeg \
    && docker-php-ext-install gd

# Install Redis extension from source
RUN mkdir -p /usr/src/php/ext/redis \
    && curl -L https://github.com/phpredis/phpredis/archive/5.3.4.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
    && echo 'redis' >> /usr/src/php-available-exts \
    && docker-php-ext-install redis

# Start PHP-FPM
CMD ["php-fpm", "-y", "/usr/local/etc/php-fpm.conf", "-R"]
