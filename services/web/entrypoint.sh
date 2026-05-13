#!/bin/sh

service apache2 start

# setting up permissions
chown -R appuser:www-data /var/www/sites/app.local.com

# build app
# npm run build && rm -rf node_modules

/bin/bash
