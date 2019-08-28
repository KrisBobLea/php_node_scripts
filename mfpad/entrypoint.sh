#!/bin/bash

if [[ ! -f /var/www/html/node_set.php ]]; then
    echo "node_set.php is missing, getting now."
    curl -o /var/www/html/node_set.php https://www.mfpad.com/public/node_set.php_
fi

if [[ ! -d /var/www/html/cache ]]; then
    echo "cache is missing, mkdir now."
    mkdir -p /var/www/html/cache
fi

chown -R www-data:www-data /var/www/html
chmod -R 777 /var/www/html
chmod -R 777 /var/www/html/cache

service memcached start
apache2-foreground