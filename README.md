# Docker - SickRage

[![Docker Repository on Quay.io](https://quay.io/repository/albertrdixon/sickrage/status "Docker Repository on Quay.io")](https://quay.io/repository/albertrdixon/sickrage)

A minimal debian based [Docker](http://www.docker.com) container running [SickRage](https://github.com/SiCKRAGETV/SickRage)

All of the SickRage awesomeness and none of the Phusion bloat!

## Usage

You can run this right out of the box with no adjustments.

```
$ docker run -d -P quay.io/albertrdixon/sickrage docker-start
```

If you want your config changes and data to persist (and of course you do), then run like so:

```
$ docker run -d -P -e SB_DATA=/data -e SB_CONFIG=/data/config.ini -v /path/to/sickrage/data:/data quay.io/albertrdixon/sickrage docker-start
```

Simple!
