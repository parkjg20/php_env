FROM ubuntu:18.04

# add repositories
ENV LANG C.UTF-8
RUN apt-get update -y
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php

RUN apt-get update -y

# apache2 setup
RUN apt-get install -y apache2

RUN a2enmod rewrite
RUN service apache2 restart

# # PHP 7.2 setup
RUN ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
RUN apt-get install -y php7.2 \
    php7.2-gd \
    php7.2-cgi \
    php7.2-cli \
    php7.2-common \
    php7.2-mbstring \
    php7.2-dom \
    php7.2-zip \
    php7.2-pdo \
    php7.2-tokenizer \
    php7.2-xml \
    php7.2-ctype \
    php7.2-json \
    php7.2-mysql \
    php7.2-curl

# php debug
RUN apt-get install -y php7.2-dev \
    automake \
    autoconf

RUN apt install -y libapache2-mod-php7.2
RUN a2enmod php7.2
RUN service apache2 restart

# mysql8.0 setup
RUN apt-get install -y wget \
    curl \
    vim \
    git

RUN wget https://dev.mysql.com/get/mysql-apt-config_0.8.13-1_all.deb

# composer 1.8.6 setup
RUN curl -s https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN composer self-update 1.8.6

# xdebug setup
RUN wget https://xdebug.org/files/xdebug-3.1.2.tgz
RUN tar -xvzf xdebug-3.1.2.tgz
RUN cd xdebug-3.1.2

RUN echo '[xDebug]' >> /etc/php/7.2/cli/php.ini
RUN echo 'zend_extension=/usr/lib/php/20170718/xdebug.so' >> /etc/php/7.2/cli/php.ini
RUN echo 'xdebug.mode=develop' >> /etc/php/7.2/cli/php.ini
RUN echo 'xdebug.start_with_request=yes' >> /etc/php/7.2/cli/php.ini
RUN echo 'xdebug.mode=debug' >> /etc/php/7.2/cli/php.ini
RUN echo 'xdebug.client_host=host.docker.internal' >> /etc/php/7.2/cli/php.ini
RUN echo 'xdebug.client_port=9003' >> /etc/php/7.2/cli/php.ini

# install expressengine
WORKDIR /sources
# RUN git clone https://github.com/xpressengine/xpressengine.git
# RUN cd ~/xpressengine
# RUN composer install


CMD ["/bin/bash", "-c", "while true; do sleep 10000; done"]
