FROM alpine:edge

MAINTAINER Conor Anderson <conor@conr.ca>

RUN apk add --update --no-cache \
	bash \
        curl \
	git \
	lighttpd \
	nodejs \
	php5 \
	php5-cgi \
	php5-ctype \
	php5-curl \
	php5-dom \
	php5-gd \
	php5-iconv \
	php5-json \
	php5-mcrypt \
	php5-openssl \
	php5-pdo \
	php5-pdo_mysql \
	php5-phar

RUN git clone --depth 1 https://github.com/twostairs/paperwork.git &&\
    mv paperwork/frontend /app &&\
    rm -rf paperwork

RUN curl -sSL https://getcomposer.org/installer | php &&\
    mv composer.phar /usr/local/bin/composer

WORKDIR /app

RUN find ./app/storage -type d -print0 | xargs -0 chmod 0755 &&\
    find ./app/storage -type f -print0 | xargs -0 chmod 0644 &&\
    composer install --prefer-source --no-interaction &&\
    npm update &&\
    npm install &&\
    npm install -g gulp bower &&\
    bower --allow-root install &&\
    gulp &&\
    chown -R lighttpd:lighttpd /app &&\
    chmod +x /app/docker-runner.sh

RUN sed -i 's/return $app;//' /app/bootstrap/start.php
RUN echo '$env = $app->detectEnvironment(function() { return "development"; }); return $app;' >> /app/bootstrap/start.php

RUN mkdir -p /run/lighttpd && \
    chown -R lighttpd:lighttpd /run/lighttpd/

COPY paperwork.ico /app/public/favicon.ico

COPY lighttpd.conf /etc/lighttpd/

VOLUME ["/app/app/storage/"]

ENV PAPERWORK_URL=paperwork.example.com

RUN echo 'if [ $(grep -c "paperwork.example.com" /app/app/config/paperwork.php) == "1" ]; then sed -i "s/paperwork.example.com/$PAPERWORK_URL/g" /app/app/config/paperwork.php; fi' > /run.sh &&\
    echo "lighttpd -f /etc/lighttpd/lighttpd.conf -D" >> /run.sh &&\
    chmod +x /run.sh

CMD ["/app/docker-runner.sh"]

EXPOSE 80

