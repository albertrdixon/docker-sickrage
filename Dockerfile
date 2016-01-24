FROM alpine:3.3
MAINTAINER Albert Dixon <albert@dixon.rocks>

VOLUME ["/data"]
ENTRYPOINT ["tini", "--", "/sbin/entry"]
CMD ["/sbin/start"]
EXPOSE 8081
ENV OPEN_FILE_LIMIT=32768 \
    PATH=/src/sickrage:$PATH \
    SB_DATA=/data \
    SB_HOME=/src/sickrage \
    SB_PORT=8081 \
    SB_USER=sickrage \
    SICKRAGE_CHANNEL=master \
    SICKRAGE_GID=7000 \
    SICKRAGE_UID=7000 \
    UPDATE_INTERVAL=1h

ADD https://github.com/albertrdixon/escarole/releases/download/v0.2.1/escarole-linux.tgz /es.tgz
COPY ["entry", "start", "/sbin/"]
COPY escarole.yml /

RUN mkdir -v /torrents /tv_shows /downloads \
    && chmod +rx /sbin/entry /sbin/start \
    && tar xvzf /es.tgz -C /bin \
    && echo "http://dl-4.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk add --update --purge \
        ca-certificates \
        git \
        py-html5lib \
        py-lxml \
        py-mako \
        py-openssl \
        py-pillow \
        python \
        tini \
        unrar \
        unzip \
    && rm -rf /es.tgz
