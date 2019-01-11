FROM richarvey/nginx-php-fpm:1.5.7
MAINTAINER ljy "sal597685816@live.cn"

RUN apk add gcc g++ m4 autoconf make readline readline-dev && wget https://ftp.postgresql.org/pub/source/v10.3/postgresql-10.3.tar.gz \
  && tar xzf postgresql-10.3.tar.gz \
  && cd postgresql-10.3 && ./configure && make && make install && /usr/local/bin/docker-php-ext-configure pgsql \
  && /usr/local/bin/docker-php-ext-install pgsql && /usr/local/bin/docker-php-ext-configure pdo_pgsql && \
  /usr/local/bin/docker-php-ext-install pdo_pgsql && no | pecl install redis && echo "extension=redis.so" > /usr/local/etc/php/conf.d/pecl-redis.ini \
  && pecl install mongodb && echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/pecl-mongodb.ini && pecl install grpc \
  && echo "extension=grpc.so" > /usr/local/etc/php/conf.d/pecl-grpc.ini && pecl install protobuf \
  && echo "extension=protobuf.so" > /usr/local/etc/php/conf.d/pecl-protobuf.ini && rm -rf /tmp/pear/download/* \
  && supervisorctl restart php-fpm && apk del gcc g++ m4 autoconf make readline readline-dev && rm -rf /var/www/html/* \
  && wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-4.0.5.tgz \
  && tar -xzf mongodb-linux-x86_64-4.0.5.tgz -C /usr/local && mv /usr/local/mongodb-linux-x86_64-4.0.5 /usr/local/mongodb \
  && export PATH=/usr/local/mongodb/bin:$PATH && source /etc/profile && rm -rf mongodb-linux-x86_64-4.0.5.tgz