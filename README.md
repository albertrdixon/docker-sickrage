# Docker - SickRage

[![Docker Repository on Quay.io](https://quay.io/repository/albertrdixon/sickrage/status "Docker Repository on Quay.io")](https://quay.io/repository/albertrdixon/sickrage)

Just a small [Docker](http://www.docker.com) container that runs [SickRage](https://github.com/SiCKRAGETV/SickRage)!

## Usage

You can run this right out of the box with no adjustments.

```
$ docker run -d -P quay.io/albertrdixon/sickrage
```

If you want your config changes and data to persist (and of course you do), then run like so:

```
$ docker run -d -P -v /path/to/sickrage/data:/data quay.io/albertrdixon/sickrage
```

Simple!

## Details

`/sickrage` - Application is installed to this path

`/data` - Sickrage data directory (mount a volume here to persist Sickrage data)

*Note*: I would also mount /etc/localtime in the container as read-only (`-v /etc/localtime:/etc/localtime:ro`)

