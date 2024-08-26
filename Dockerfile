FROM php:8.3-alpine

# Setup working directory
WORKDIR /var/www
# Install necessary packages and dependencies
RUN apk add --no-cache \
    bash \
    openssl \
    nodejs \
    npm \
    alpine-sdk \
    autoconf \
    gd \
    freetype-dev \
    libzip-dev \
    zip \
    unzip \
    nginx \
    supervisor \
    wget \
    git \
    procps \
    htop \
    less \
    libpng-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    zlib-dev \
    libxpm-dev \
    libsodium-dev \
    postgresql-dev \
    imagemagick-dev \
    poppler-utils \
    linux-headers

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo pdo_pgsql pdo_mysql bcmath zip sockets pcntl \
    && docker-php-ext-configure pcntl --enable-pcntl
# Install and enable PECL extensions
RUN pecl install pcov redis \
    && docker-php-ext-enable pcov redis
# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# Install PHP_CodeSniffer globally
RUN composer global require "squizlabs/php_codesniffer=*"
# Create log directory and set permissions
RUN mkdir /var/log/php \
    && touch /var/log/php/errors.log \
    && chmod 777 /var/log/php/errors.log
# Cleanup
RUN rm -rf /var/cache/apk/* /tmp/* /usr/share/man /usr/share/doc