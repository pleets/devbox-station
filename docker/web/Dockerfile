FROM php:7.4-apache

COPY --from=composer /usr/bin/composer /usr/bin/composer

# copy scripts and binaries
COPY ./bin/ /usr/local/bin/
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
