FROM nextcloud:21.0.0-fpm-alpine

RUN apk add --no-cache supervisor \
  && mkdir /var/log/supervisord /var/run/supervisord

COPY supervisord.conf /

ENV NEXTCLOUD_UPDATE=1

#facedetection
RUN wget https://github.com/goodspb/pdlib/archive/master.zip \
  && mkdir -p /usr/src/php/ext/ \
  && unzip -d /usr/src/php/ext/ master.zip \
  && rm master.zip
RUN docker-php-ext-install pdlib-master

RUN apk add bzip2-dev
RUN docker-php-ext-install bz2

CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf"]