# Use an official PHP image as the base image
FROM php:8.2-fpm

# Set working directory
WORKDIR /var/www/html

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libzip-dev \
    libssl-dev \
    pkg-config \
    libcurl4-openssl-dev \
    zlib1g-dev \
    libgmp-dev \
    libmcrypt-dev \
    libicu-dev \
    g++ \
    make \
    autoconf \
    libbrotli-dev \
    nodejs \
    npm

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd intl gmp

# Install Swoole extension
RUN pecl install swoole \
    && docker-php-ext-enable swoole

# Install chokidar globally
RUN npm install -g chokidar-cli

# Install Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Copy existing application directory contents
COPY . /var/www/html

# Copy existing application directory permissions
COPY --chown=www-data:www-data . /var/www/html

# Set up correct permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage \
    && chmod +x /usr/local/bin/php # Ensure correct execution permissions

# Install Composer dependencies
RUN composer install --no-dev --no-interaction --ignore-platform-reqs

# Expose the port Octane will run on
EXPOSE 8000

# Run Laravel Octane
CMD ["php", "artisan", "octane:start", "--server=swoole", "--host=0.0.0.0", "--port=8000"]
