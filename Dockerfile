FROM alpine:3.2
MAINTAINER Albert Dixon <albert.dixon@schange.com>

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk update
RUN apk add bash git unrar ca-certificates \
    python py-openssl py-mako py-pillow \
    supervisor

ADD https://github.com/albertrdixon/tmplnator/releases/download/v2.2.0/t2-linux.tgz /t2.tgz
RUN tar xvzf /t2.tgz -C /usr/local \
    && ln -s /usr/local/bin/t2-linux /usr/local/bin/t2 \
    && rm -f /t2.tgz

ADD https://github.com/albertrdixon/escarole/releases/download/v0.1.1/escarole-linux.tgz /es.tgz
RUN tar xvzf /es.tgz -C /usr/local \
    && ln -s /usr/local/bin/escarole-linux /usr/local/bin/escarole \
    && rm -f /es.tgz

RUN git clone -v --depth 1 git://github.com/SiCKRAGETV/SickRage.git /sickrage

ADD bashrc /root/.profile
ADD configs /templates
ADD scripts/* /usr/local/bin/
RUN chown root:root /usr/local/bin/* &&\
    chmod a+rx /usr/local/bin/*
RUN bash -c "mkdir /{data,torrents,tv_shows,downloads}"

ENTRYPOINT ["docker-entry"]
CMD ["docker-start"]
EXPOSE 8081

ENV PATH                 /usr/local/bin:$PATH
ENV OPEN_FILE_LIMIT      32768
ENV SUPERVISOR_LOG_LEVEL INFO
ENV SICKRAGE_CHANNEL     master
ENV UPDATE_INTERVAL      4h
ENV SB_HOME              /sickrage
ENV SB_USER              root
ENV SB_PORT              8081
ENV SB_DATA              /data
