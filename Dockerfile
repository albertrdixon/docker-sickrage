FROM debian:jessie
MAINTAINER Albert Dixon <albert@timelinelabs.com>

ENV PATH /usr/local/bin:$PATH
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y --no-install-recommends --force-yes \
    git-core python python-cheetah \
    unar wget curl supervisor \
    ca-certificates locales

RUN dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8

RUN curl -#kL https://github.com/jwilder/dockerize/releases/download/v0.0.2/dockerize-linux-amd64-v0.0.2.tar.gz |\
    tar xvz -C /usr/local/bin

RUN git clone -v git://github.com/SiCKRAGETV/SickRage.git /sickrage &&\
    ln -svf /usr/bin/unar /sickrage/lib/unrar2/unrar

ADD configs /templates
ADD docker-* /usr/local/bin/
RUN chmod a+rx /usr/local/bin/docker-*
RUN bash -c "mkdir /{data,torrents,shows,downloads}"

WORKDIR /sickrage
ENTRYPOINT ["docker-entry"]
VOLUME ["/torrents"]
EXPOSE 8081

ENV SUPERVISOR_LOG_LEVEL INFO
ENV SICKRAGE_CHANNEL master
ENV SB_HOME          /sickrage
ENV SB_USER          root
ENV SB_PORT          8081
ENV SB_DATA          /data