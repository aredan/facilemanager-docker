FROM php:8.0-apache

ENV VERSION=4.6.2
LABEL maintainer="Ariel Antigua <me@arielantigua.com>"
WORKDIR /src

RUN	apt-get update \
	&& apt-get -qqy install wget libldb-dev libldap2-dev \
	&& wget http://www.facilemanager.com/download/facilemanager-complete-${VERSION}.tar.gz \
	&& tar -xvf facilemanager-complete-${VERSION}.tar.gz \
	&& mv facileManager/server/* /var/www/html/

RUN ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/libldap.so 
RUN docker-php-ext-install mysqli ldap 
RUN a2enmod rewrite dump_io

COPY fmdns/config.inc.php /var/www/html/
COPY php.ini /usr/local/etc/php/php.ini
