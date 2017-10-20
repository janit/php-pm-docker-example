FROM debian:stretch

RUN apt-get update \
	&& apt-get -y install wget apt-transport-https lsb-release ca-certificates \
	&& wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
	&& echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list \
	&& apt-get update \
	&& apt-get -y install git zlib1g-dev php7.1 php7.1-cgi php7.1-zip php7.1-curl php7.1-opcache php7.1-xml php7.1-mbstring php7.1-imagick php7.1-gd

COPY docker/app/php.ini /etc/php/7.1/cgi/conf.d/99-phppm.ini
COPY docker/app/php.ini /etc/php/7.1/cli/conf.d/99-phppm.ini

COPY docker/app/install-composer.sh /usr/local/bin/docker-app-install-composer
RUN chmod +x /usr/local/bin/docker-app-install-composer

RUN set -xe \
	&& docker-app-install-composer \
	&& mv composer.phar /usr/local/bin/composer

# https://getcomposer.org/doc/03-cli.md#composer-allow-superuser
ENV COMPOSER_ALLOW_SUPERUSER 1

RUN composer global require "hirak/prestissimo:^0.3" --prefer-dist --no-progress --no-suggest --optimize-autoloader --classmap-authoritative \
	&& composer clear-cache

WORKDIR /srv/app

COPY . .
# Cleanup unneeded files
RUN rm -Rf docker/

RUN mkdir -p var/cache var/logs var/sessions \
    && composer install --prefer-dist --no-progress --no-suggest --optimize-autoloader --classmap-authoritative --no-interaction \
	&& composer clear-cache \
	&& chown -R www-data var

RUN git clone https://github.com/php-pm/php-pm.git \
    && cd php-pm \
	&& composer install \
	&& ln -s `pwd`/bin/ppm /usr/local/bin/ppm \
	&& ppm --help

RUN ls -la /usr/local/bin

CMD ["php","/usr/local/bin/ppm","start"]