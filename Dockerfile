# based on debian jessie
FROM debian:jessie
MAINTAINER Gather Digital <hello@gatherdigital.co.uk>

RUN apt-get update && \
 DEBIAN_FRONTEND=noninteractive apt-get -y upgrade && \
 DEBIAN_FRONTEND=noninteractive apt-get -y install wget sudo pwgen apt-utils

ADD sources.list /tmp/sources.list
RUN cat /tmp/sources.list >> /etc/apt/sources.list

RUN wget -O - http://www.dotdeb.org/dotdeb.gpg | apt-key add -

RUN apt-get update

# install basic tools
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
 git \
 curl \
 bzip2 \
 unzip \
 build-essential \
 autoconf \
 cabextract
 

# install php packages
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
 php7.0 \
 php7.0-bcmath \
 php7.0-bz2 \
 php7.0-common \
 php7.0-cli \
 php7.0-curl \
 php7.0-dev \
 php7.0-fpm \
 php7.0-gd \
 php7.0-imagick \
 php7.0-imap \
 php7.0-intl \
 php7.0-json \
 php7.0-mbstring \
 php7.0-mcrypt \
 php7.0-mysql \
 php7.0-opcache \
 php7.0-soap \
 php7.0-ssh2 \
 php7.0-xml \
 php7.0-zip

WORKDIR /tmp

# install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

# install node & npm
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get install -y nodejs

# install webpack
RUN npm i -g webpack

VOLUME ["/app"]
WORKDIR /app

CMD ["php","-v"]
