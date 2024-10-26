#!/bin/bash

set -e

env

if [[ -n "$1" ]]; then
    exec "$@"
else
    composer install
    wait-for-it db:5432 -t 45
    php artisan migrate --database=pgsql
    chown -R www-data:www-data storage
    exec apache2-foreground
fi
