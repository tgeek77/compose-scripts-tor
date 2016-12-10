FROM ubuntu:latest
RUN apt-get update && apt-get install -y apache2
RUN apt-get install -y php7.0 \
	libapache2-mod-php7.0 \
	php7.0-mysql \
	php7.0-curl \
	php7.0-gd \
	php7.0-intl \
	php-pear \
	php-imagick \
	php7.0-imap \
	php7.0-mcrypt \
	php-memcache \ 
	php7.0-pspell \
	php7.0-recode \
	php7.0-sqlite3 \
	php7.0-tidy \
	php7.0-xmlrpc \
	php7.0-xsl \
	php7.0-mbstring \
	php-gettext \
	php-phpseclib \
	php-tcpdf
CMD /usr/sbin/apache2ctl -D FOREGROUND
EXPOSE 80
