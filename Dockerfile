FROM composer:latest AS composer

FROM php:7.4-cli
COPY --from=composer /usr/bin/composer /usr/local/bin/composer

ENV WORKDIR /app
WORKDIR ${WORKDIR}

#--------------------------------------------------------------------------------------------------
# Install OS packages
#--------------------------------------------------------------------------------------------------

RUN apt-get update -y

# Requirement for Composer and necessary tools
RUN apt-get install -y zlibc git zip unzip zlib1g-dev libicu-dev g++ vim

#--------------------------------------------------------------------------------------------------
# Install PHP Modules
#--------------------------------------------------------------------------------------------------

# Install PHP XDebug, do not have on production
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
COPY config/xdebug/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

#--------------------------------------------------------------------------------------------------
# Post setup
#--------------------------------------------------------------------------------------------------

# Clean out directory
RUN apt-get clean -y
