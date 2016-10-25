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
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
 php7.0-fpm \
 php7.0-cli \
 php7.0-curl \
 php7.0-dev \
 php7.0-gd \
 php7.0-imagick \
 php7.0-imap \
 php7.0-intl \
 php7.0-mcrypt \
 php7.0-mysql \
 php7.0-sqlite \
 bzip2 \
 unzip \
 build-essential \
 autoconf \
 cabextract

# install tools
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
 git \
 curl

WORKDIR /tmp

# install compoesr
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

VOLUME ["/app"]
WORKDIR /app

CMD ["php","-v"]
