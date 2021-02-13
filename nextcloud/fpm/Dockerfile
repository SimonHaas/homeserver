# iamklaus - ENJOY IT
# Use a temporary image to compile and test the libraries
#
FROM nextcloud:fpm as builder

# Build and install dlib on builder

RUN apt-get update ; \
    apt-get install -y build-essential wget cmake libx11-dev libopenblas-dev shtool

ARG DLIB_BRANCH=v19.19
RUN cd; \
    wget -c -q https://github.com/davisking/dlib/archive/$DLIB_BRANCH.tar.gz \
    && tar xf $DLIB_BRANCH.tar.gz \
    && mv dlib-* dlib \
    && cd dlib/dlib \
    && mkdir build \
    && cd build \
    && cmake -DBUILD_SHARED_LIBS=ON --config Release .. \
    && make \
    && make install

# Build and install PDLib on builder

ARG PDLIB_BRANCH=master
RUN apt-get install unzip
RUN cd; \
    wget -c -q https://github.com/matiasdelellis/pdlib/archive/$PDLIB_BRANCH.zip \
    && unzip $PDLIB_BRANCH \
    && mv pdlib-* pdlib \
    && cd pdlib \
    && phpize \
    && ./configure \
    && make \
    && make install

# Enable PDlib on builder

# If necesary take the php settings folder uncommenting the next line
# RUN php -i | grep "Scan this dir for additional .ini files"
RUN echo "extension=pdlib.so" > /usr/local/etc/php/conf.d/pdlib.ini

# Test PDlib instalation on builer

RUN apt-get install -y git
RUN cd; \
    git clone https://github.com/matiasdelellis/pdlib-min-test-suite.git \
    && cd pdlib-min-test-suite \
    && make

#
# If pass the tests, we are able to create the final image.
#

FROM nextcloud:fpm

# Install dependencies to image

RUN apt-get update ; \
    apt-get install -y libopenblas-base

# Install dlib and PDlib to image

COPY --from=builder /usr/local/lib/libdlib.so* /usr/local/lib/

# If is necesary take the php extention folder uncommenting the next line
# RUN php -i | grep extension_dir
COPY --from=builder  /usr/local/lib/php/extensions/no-debug-non-zts-20190902/pdlib.so /usr/local/lib/php/extensions/no-debug-non-zts-20190902/

# Enable PDlib on final image

RUN echo "extension=pdlib.so" > /usr/local/etc/php/conf.d/pdlib.ini

# Increse memory limits

RUN echo 'memory_limit=${MEMORY_LIMIT}' > /usr/local/etc/php/conf.d/memory-limit.ini

# At this point you meet all the dependencies to install the application
# If is available you can skip this step and install the application from the application store
#
ARG FR_BRANCH=master
RUN apt-get install -y wget unzip nodejs npm
RUN wget -c -q -O facerecognition https://github.com/matiasdelellis/facerecognition/archive/$FR_BRANCH.zip \
  && unzip facerecognition \
  && mv facerecognition-*  /usr/src/nextcloud/facerecognition \
  && cd /usr/src/nextcloud/facerecognition \
  && make;

RUN set -ex;

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ffmpeg \
        libmagickcore-6.q16-6-extra \
        procps \
        smbclient \
        supervisor \
        libreoffice \
        vim \
        libfuse2 \
        fuse \
        fontconfig \
        exiftool \
        gnupg

RUN set -ex; \
    \
    savedAptMark="$(apt-mark showmanual)"; \
    \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        libbz2-dev \
        libc-client-dev \
        libkrb5-dev \
        libsmbclient-dev \
    ; \
    \
    docker-php-ext-configure imap --with-kerberos --with-imap-ssl; \
    docker-php-ext-install \
        bz2 \
        imap \
    ; \
    pecl install smbclient; \
    docker-php-ext-enable smbclient; \
    \
# reset apt-mark's "manual" list so that "purge --auto-remove" will remove all build dependencies
    apt-mark auto '.*' > /dev/null; \
    apt-mark manual $savedAptMark; \
    ldd "$(php -r 'echo ini_get("extension_dir");')"/*.so \
        | awk '/=>/ { print $3 }' \
        | sort -u \
        | xargs -r dpkg-query -S \
        | cut -d: -f1 \
        | sort -u \
        | xargs -rt apt-mark manual; \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
    rm -rf /var/lib/apt/lists/*; \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
;

RUN mkdir -p \
    /var/log/supervisord \
    /var/run/supervisord \
;

COPY supervisord.conf /

ENV NEXTCLOUD_UPDATE=1
ENV MEMORY_LIMIT=1G

RUN echo '*/30 * * * * php -f /var/www/html/occ face:background_job -t 900' >> /var/spool/cron/crontabs/www-data
CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf"]