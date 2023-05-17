ARG PHP_VERSION=8.2

FROM php:${PHP_VERSION}-apache

COPY --from=composer /usr/bin/composer /usr/bin/composer

ARG NODE_VERSION=14
ENV NODE_VERSION ${NODE_VERSION}

##########################################################################################
# Nuxt.js configuration
#
# NUXT_PORT is by default 3000.
# NUXT_PORT in docker-compose only change the way you access from outside the container.
##########################################################################################
ENV NUXT_HOST=0.0.0.0

# copy scripts and binaries
COPY ./bin/ /usr/local/bin/
COPY ./etc/apache2/apache2.conf /etc/apache2/apache2.conf
COPY ./etc/apache2/docker-vhosts /etc/apache2/docker-vhosts
RUN chmod +x /usr/local/bin/*

RUN apt-get -y update \
    && apt-get -y install \
    libpng-dev \
    libzip-dev \
    libxml2-dev \
    iputils-ping \
    vim \
    wget \
    unzip \
    && a2enmod rewrite \
    && docker-php-ext-install pdo_mysql intl gd zip

RUN pecl install redis && docker-php-ext-enable redis

# NodeJS and NPM installation
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

ARG PUID=1000
ENV PUID ${PUID}
ARG PGID=1000
ENV PGID ${PGID}

RUN useradd -u ${PUID} -g www-data -m appuser

# Entry point
USER root
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD tail -f /dev/null
