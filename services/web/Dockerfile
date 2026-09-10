ARG PHP_VERSION=8.4

FROM php:${PHP_VERSION}-apache

COPY --from=composer /usr/bin/composer /usr/bin/composer

ARG NODE_VERSION=24
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
    libicu-dev \
    libgmp3-dev \
    libssl-dev \
    libsodium-dev \
    && apt clean

RUN apt-get -y install \
    --no-install-recommends \
    iputils-ping  \
     vim-tiny \
     wget \
     w3m \
     zip unzip \
     openssl  \
     && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite headers
RUN docker-php-ext-install pdo_mysql intl
RUN docker-php-ext-install gd gmp ftp

RUN docker-php-ext-install sodium
RUN docker-php-ext-install xml zip

RUN pecl install redis && docker-php-ext-enable redis

# Create the directory for nvm
RUN mkdir -p /opt/nvm

# Set up nvm environment variables globally
ENV NVM_DIR /opt/nvm

# Install nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Activate nvm in bash profiles (nvm CLI in login shells)
RUN echo "export NVM_DIR=${NVM_DIR}" >> /etc/profile.d/nvm.sh \
    && echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> /etc/profile.d/nvm.sh \
    && chmod +x /etc/profile.d/nvm.sh

# Install Node.js and expose node/npm/npx on PATH for non-login shells (entrypoint, deploy scripts)
RUN . "$NVM_DIR/nvm.sh" \
    && nvm install ${NODE_VERSION} \
    && ln -sf "$(command -v node)" /usr/local/bin/node \
    && ln -sf "$(command -v npm)" /usr/local/bin/npm \
    && ln -sf "$(command -v npx)" /usr/local/bin/npx

ARG PUID=1000
ENV PUID ${PUID}
ARG PGID=1000
ENV PGID ${PGID}

RUN useradd -u ${PUID} -g www-data -m appuser

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER appuser

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD tail -f /dev/null
