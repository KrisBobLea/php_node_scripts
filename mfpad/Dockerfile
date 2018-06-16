FROM php:7.2.6-apache-stretch

# RUN sed -i "s/deb.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list && \
#   sed -i "s/deb.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list && \

COPY start.sh /

RUN apt-get update && \
    # ---------- install php ext: zip
    apt-get install -y zlib1g-dev && \
    docker-php-ext-install zip && \
    # ---------- install php ext: memcache
    apt-get install -y --no-install-recommends unzip libssl-dev libpcre3 libpcre3-dev && \
    cd /tmp && \
    curl -sSL -o php7.zip https://github.com/websupport-sk/pecl-memcache/archive/php7.zip && \
    unzip php7 && \
    cd pecl-memcache-php7 && \
    /usr/local/bin/phpize && \
    ./configure --with-php-config=/usr/local/bin/php-config && \
    make && make install && \
    echo "extension=memcache.so" > /usr/local/etc/php/conf.d/ext-memcache.ini && \
    rm -rf /tmp/pecl-memcache-php7 php7.zip && \
    # ---------- get node_set.php
    cd /var/www/html && \
    curl -o /var/www/html/node_set.php https://www.mfpad.com/public/node_set.php_ && \
    chown www-data node_set.php && \
    chmod -R 777 /var/www/html && \
    # ---------- install memcached
    apt-get install -y memcached netcat && \
    service memcached start

CMD ["bash", "/start.sh"]