# Docker - SickRage

[![Docker Repository on Quay.io](https://quay.io/repository/albertrdixon/sickrage/status "Docker Repository on Quay.io")](https://quay.io/repository/albertrdixon/sickrage)

A minimal debian based [Docker](http://www.docker.com) container running [SickRage](https://github.com/SiCKRAGETV/SickRage)

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

## Environment Variables

| Var Name | Default Value | Description |
|----------|---------------|-------------|
| `GIT_USERNAME` | "" | Your [github](github.com) username (for all github features) |
| `GIT_PASSWORD` | "" | Your [github](github.com) password |
| `SICKRAGE_CHANNEL` | master | The Sickrage channel (or branch) to use. Either master or develop |
| `USERNAME` | "" | Sickrage web UI username. Leave blank for no login |
| `PASSWORD` | "" | Sickrage web UI password. Leave blank for no authentication |
| `TORRENT_HOST` | "http://torrent/" | Address for your torrent client. Don't forget to include the port (if needed) |
| `TORRENT_USERNAME` | "" | Username for torrent client connection |
| `TORRENT_PASSWORD` | "" | Password for torrent client connection |
| `ANIDB_USERNAME` | "" | Username for [AniDB](http://anidb.net/) |
| `ANIDB_PASSWORD` | "" | Password for [AniDB](http://anidb.net/) |