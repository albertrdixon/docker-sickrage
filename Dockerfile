FROM python:2.7.9
MAINTAINER Albert Dixon <albert@timelinelabs.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y --no-install-recommends --force-yes \
    git-core unar wget curl dnsmasq \
    ca-certificates locales

RUN dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8

RUN curl -#kL https://github.com/jwilder/dockerize/releases/download/v0.0.2/dockerize-linux-amd64-v0.0.2.tar.gz |\
    tar xvz -C /usr/local/bin

RUN virtualenv venv
ADD requirements.txt requirements.txt
RUN venv/bin/pip install -r requirements.txt && rm requirements.txt

RUN git clone -v git://github.com/SiCKRAGETV/SickRage.git /sickrage &&\
    ln -svf /usr/bin/unar /sickrage/lib/unrar2/unrar &&\
    ln -svf /usr/bin/unar /usr/bin/unrar

RUN apt-get purge -y --auto-remove \
    gcc libc6-dev libsqlite3-dev libssl-dev \
    make xz-utils zlib1g-dev
RUN apt-get autoremove -y && apt-get autoclean -y &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD configs /templates
ADD scripts/* /usr/local/bin/
RUN chown root:root /usr/local/bin/* &&\
    chmod a+rx /usr/local/bin/*
RUN bash -c "mkdir /{data,torrents,tv_shows,downloads}"

WORKDIR /sickrage
ENTRYPOINT ["docker-entry"]
CMD ["docker-start"]
VOLUME ["/torrents"]
EXPOSE 8081

ENV PATH                 /usr/local/bin:$PATH
ENV OPEN_FILE_LIMIT      32768
ENV SUPERVISOR_LOG_LEVEL INFO
ENV SICKRAGE_CHANNEL     master
ENV UPDATE_FREQUENCY     28800
ENV SB_HOME              /sickrage
ENV SB_USER              root
ENV SB_PORT              8081
ENV SB_DATA              /data