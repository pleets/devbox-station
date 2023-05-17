#!/bin/sh

service apache2 start

# setting up permissions
chown -R appuser:www-data /var/www/sites/app.local.com

# nodejs and npm
export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install node && nvm use node
nvm install ${NODE_VERSION} && nvm use ${NODE_VERSION}

/bin/bash
