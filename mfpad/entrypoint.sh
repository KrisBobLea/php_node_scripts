#!/bin/bash

if [[ ! -f /var/www/html/node_set.php ]]; then
    echo "node_set.php is missing, getting now."
    curl -o /var/www/html/node_set.php https://www.mfpad.com/public/node_set.js
fi

chown -R www-data:www-data /var/www/html
chmod 777 /var/www/html
chmod 777 /var/www/html/cache

apache2-foreground
