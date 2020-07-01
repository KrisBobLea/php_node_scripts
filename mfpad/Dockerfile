FROM php:7.3.19-apache-stretch

# RUN sed -i "s/deb.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list && \
#   sed -i "s/deb.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list && \

COPY apache2.conf /etc/apache2/apache2.conf
COPY entrypoint.sh /usr/local/bin/entrypoint

RUN apt-get update && \
    # ---------- install php ext: zip
    apt-get install -y zlib1g-dev dumb-init openssl wget procps git && \
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
    # ---------- install memcached
    apt-get install -y netcat && \
    chmod +x /usr/local/bin/entrypoint

    # ---------- install swoole
RUN cd /tmp && git clone https://github.com/swoole/swoole-src.git && \
    cd swoole-src && \
    git checkout v4.5.2 && \
    phpize  && \
    ./configure  --enable-sockets=no --enable-openssl=no --enable-http2=no --enable-mysqlnd=no && \
    make && make install

RUN touch /usr/local/etc/php/conf.d/swoole.ini && \
    echo 'extension=swoole.so' > /usr/local/etc/php/conf.d/swoole.ini


# mongo
RUN pecl install mongodb \
    && docker-php-ext-enable mongodb

    WORKDIR /var/www/html

# ------------ Enable mod_rewrite
RUN a2enmod rewrite


RUN apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["dumb-init", "entrypoint"]


