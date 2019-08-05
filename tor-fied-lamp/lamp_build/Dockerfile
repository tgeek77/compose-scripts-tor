FROM ubuntu:bionic
RUN apt-get update && apt-get install -y apache2
RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install php7.2 \
	libapache2-mod-php7.2 \
	php7.2-mysql \
	php7.2-curl \
	php7.2-gd \
	php7.2-intl \
	php-pear \
	php-imagick \
	php7.2-imap \
	php-memcache \ 
	php7.2-pspell \
	php7.2-recode \
	php7.2-sqlite3 \
	php7.2-tidy \
	php7.2-xmlrpc \
	php7.2-xsl \
	php7.2-mbstring \
	php-gettext \
	php-phpseclib \
	php-tcpdf
COPY apache2.conf /etc/apache2/
COPY 000-default.conf /etc/apache2/sites-available/
COPY other-vhosts-access-log.conf /etc/apache2/conf-available/other-vhosts-access-log.conf
CMD /usr/sbin/apache2ctl -D FOREGROUND
EXPOSE 80
