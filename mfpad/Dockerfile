FROM php:7.2.6-apache-stretch

# RUN sed -i "s/deb.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list && \
#   sed -i "s/deb.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list && \

COPY apache2.conf /etc/apache2/apache2.conf
COPY entrypoint.sh /usr/local/bin/entrypoint

RUN apt-get update && \
    # ---------- install php ext: zip
        apt-get install -y zlib1g-dev dumb-init && \
            docker-php-ext-install zip && \
                chmod +x /usr/local/bin/entrypoint

# mongo
RUN pecl install mongodb \
    && docker-php-ext-enable mongodb

    WORKDIR /var/www/html

# ------------ Enable mod_rewrite
RUN a2enmod rewrite

ENTRYPOINT ["dumb-init", "entrypoint"]


