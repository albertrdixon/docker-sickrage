FROM debian:jessie
MAINTAINER Albert Dixon <albert@timelinelabs.com>

ENV PATH /usr/local/bin:$PATH
ENV DEBIAN_FRONTEND noninteractive

ENV SICKRAGE_CHANNEL master
ENV SB_HOME /sickrage

RUN apt-get update -qq &&\
    apt-get install -y --no-install-recommends git python python-cheetah \
    unrar-free unar unzip wget curl ca-certificates runit &&\
    apt-get autoclean -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone -b $SICKRAGE_CHANNEL git://github.com/SiCKRAGETV/SickRage.git "$SB_HOME" &&\
    mkdir /torrents

RUN mkdir -p /etc/service/sickrage
COPY sickrage.sh /etc/service/sickrage/run
COPY docker-start.sh /usr/local/bin/docker-start
RUN chmod a+rx /usr/local/bin/docker-start /etc/service/sickrage/run/sickrage.sh

WORKDIR /sickrage
ENTRYPOINT ["docker-start"]
VOLUME ["/torrents"]
EXPOSE 8081

ENV SB_USER   root
ENV SB_PORT   8081
ENV SB_DATA   /sickrage/data