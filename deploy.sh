#!/usr/bin/env bash
set -o errexit

# Install PHP and required extensions
sudo apt-get update && sudo apt-get install -y \
    php8.2 \
    php8.2-common \
    php8.2-cli \
    php8.2-mysql \
    php8.2-zip \
    php8.2-gd \
    php8.2-mbstring \
    php8.2-curl \
    php8.2-xml \
    php8.2-bcmath \
    php8.2-fpm \
    php8.2-intl

# Install Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Install dependencies
composer install --no-dev --optimize-autoloader

# Generate application key
php artisan key:generate --force

# Optimize configuration loading
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Set permissions
chmod -R 775 storage bootstrap/cache