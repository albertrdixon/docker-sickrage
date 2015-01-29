FROM debian:jessie
MAINTAINER Albert Dixon <albert@timelinelabs.com>

ENV PATH /usr/local/bin:$PATH
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y --no-install-recommends --force-yes \
    git-core python python-cheetah \
    unrar-free unar unzip wget curl \
    ca-certificates supervisor locales

RUN dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8

RUN apt-get autoremove -y && apt-get autoclean -y &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD https://github.com/jwilder/dockerize/releases/download/v0.0.2/dockerize-linux-amd64-v0.0.2.tar.gz /
RUN tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.0.2.tar.gz &&\
    rm -rf dockerize-linux-amd64-v0.0.2.tar.gz

RUN git clone git://github.com/SiCKRAGETV/SickRage.git /sickrage &&\
    mkdir /torrents

ADD configs/config.ini.tpl /templates/
ADD supervisord/* /etc/supervisor/conf.d/
ADD scripts/docker-start /usr/local/bin/
RUN chmod a+rx /usr/local/bin/docker-start &&\
    mkdir /data

WORKDIR /sickrage
ENTRYPOINT ["docker-start"]
VOLUME ["/torrents"]
EXPOSE 8081

ENV SICKRAGE_CHANNEL master
ENV SB_HOME          /sickrage
ENV SB_USER          root
ENV SB_PORT          8081
ENV SB_DATA          /data