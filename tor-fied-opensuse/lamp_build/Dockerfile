FROM opensuse/leap
RUN zypper ref && zypper -n install apache2
RUN zypper -n install php7 \
	apache2-mod_php7 \
	php7-mysql \
	php7-curl \
	php7-gd \
	php7-intl \
	php7-pear \
	php7-imagick \
	php7-memcached \ 
	php7-sqlite \
	php7-tidy \
	php7-xmlrpc \
	php7-xsl \
	php7-mbstring \
	php7-gettext 
#COPY apache2.conf /etc/apache2/
COPY global.conf /etc/apache2/
COPY global.conf /etc/apache2/sysconfig.d/
CMD /usr/sbin/apache2ctl -D FOREGROUND
EXPOSE 80
