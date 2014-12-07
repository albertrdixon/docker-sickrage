FROM debian:jessie
MAINTAINER Albert Dixon <albert@timelinelabs.com>

ENV PATH /usr/local/bin:$PATH
ENV DEBIAN_FRONTEND noninteractive

ENV SICKRAGE_CHANNEL master
ENV SB_HOME /sickrage

RUN apt-get update -qq &&\
    apt-get install -y --no-install-recommends git python python-cheetah \
    unrar-free unar ca-certificates &&\
    apt-get remove -y --purge $(dpkg --get-selections | egrep "\-dev:?" | cut -f1) &&\
    apt-get autoclean -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone -b $SICKRAGE_CHANNEL git://github.com/echel0n/SickRage.git $SB_HOME &&\
    mkdir /torrents
COPY docker-start.sh /usr/local/bin/docker-start
RUN chmod 0755 /usr/local/bin/docker-start

CMD ["docker-start"]
VOLUME ["/torrents"]
EXPOSE 8081