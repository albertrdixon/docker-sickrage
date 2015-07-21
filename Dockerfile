FROM debian:jessie
MAINTAINER Albert Dixon <albert.dixon@schange.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    curl git python python-dev libssl-dev gcc \
    locales supervisor ca-certificates dnsmasq \
    libxml2-dev libxslt-dev \
    && curl -#kL https://bootstrap.pypa.io/get-pip.py | python

RUN dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8

ADD requirements.txt /requirements.txt
RUN pip install -U -r /requirements.txt

RUN curl -#kL https://github.com/albertrdixon/tmplnator/releases/download/v2.1.0/tnator-linux-amd64.tar.gz |\
    tar xvz -C /usr/local/bin

RUN curl -#kL https://github.com/albertrdixon/escarole/releases/download/v0.1.0/escarole-linux.tar.gz |\
    tar xvz -C /usr/local/bin

RUN git clone -v git://github.com/SiCKRAGETV/SickRage.git /sickrage

ADD bashrc /root/.bashrc
ADD configs /templates
ADD scripts/* /usr/local/bin/
RUN chown root:root /usr/local/bin/* &&\
    chmod a+rx /usr/local/bin/*
RUN bash -c "mkdir /{data,torrents,tv_shows,downloads}"

ENTRYPOINT ["docker-entry"]
CMD ["docker-start"]

ENV PATH                 /usr/local/bin:$PATH
ENV OPEN_FILE_LIMIT      32768
ENV SUPERVISOR_LOG_LEVEL INFO
ENV SICKRAGE_CHANNEL     master
ENV UPDATE_INTERVAL      4h
ENV SB_HOME              /sickrage
ENV SB_USER              root
ENV SB_PORT              8081
ENV SB_DATA              /data
