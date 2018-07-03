<p align="center"><a href="https://github.com/crazy-max/docker-snmpd" target="_blank"><img height="128"src="https://raw.githubusercontent.com/crazy-max/docker-snmpd/master/.res/docker-snmpd.jpg"></a></p>

<p align="center">
  <a href="https://microbadger.com/images/crazymax/snmpd"><img src="https://images.microbadger.com/badges/version/crazymax/snmpd.svg?style=flat-square" alt="Version"></a>
  <a href="https://travis-ci.org/crazy-max/docker-snmpd"><img src="https://img.shields.io/travis/crazy-max/docker-snmpd/master.svg?style=flat-square" alt="Build Status"></a>
  <a href="https://hub.docker.com/r/crazymax/snmpd/"><img src="https://img.shields.io/docker/stars/crazymax/snmpd.svg?style=flat-square" alt="Docker Stars"></a>
  <a href="https://hub.docker.com/r/crazymax/snmpd/"><img src="https://img.shields.io/docker/pulls/crazymax/snmpd.svg?style=flat-square" alt="Docker Pulls"></a>
  <a href="https://quay.io/repository/crazymax/snmpd"><img src="https://quay.io/repository/crazymax/snmpd/status?style=flat-square" alt="Docker Repository on Quay"></a>
  <a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=YCXXELQ7WCBMA"><img src="https://img.shields.io/badge/donate-paypal-7057ff.svg?style=flat-square" alt="Donate Paypal"></a>
</p>

## About

🐳 [SNMP daemon (snmpd)](http://www.net-snmp.org/) Docker image based on Alpine Linux.<br />
If you are interested, [check out](https://hub.docker.com/r/crazymax/) my other 🐳 Docker images!

## Features

* SNMP daemon patched to be able to monitor on CoreOS (use `/hostproc` instead of `/proc`)
* Fix [CVE-2015-5621](https://nvd.nist.gov/vuln/detail/CVE-2015-5621)
* IPv6 disabled

## Ports

* `161/udp` : snmpd UDP listen port

## Usage

> :warning: snmpd has been patched to use `/hostproc` and not `/proc`.

### Docker Compose

Docker compose is the recommended way to run this image. Edit the compose file with your preferences in [examples/compose](examples/compose) and run the following command :

```bash
$ docker-compose up -d
$ docker-compose logs -f
```

### Command line

You can also use the following minimal command :

```bash
$ docker run -d --name snmpd \
  --privileged \
  -p 161:161/udp \
  -v /proc:/hostproc \
  crazymax/snmpd:latest
```

You can also mount your own `snmpd.conf` :

```bash
$ docker run -d --name snmpd \
  --privileged \
  -p 161:161/udp \
  -v /proc:/hostproc \
  -v $(pwd)/snmpd.conf:/etc/snmpd.conf \
  crazymax/snmpd:latest
```

## Upgrade

To upgrade, pull the newer image and launch the container :

```bash
docker-compose pull
docker-compose up -d
```

## How can i help ?

All kinds of contributions are welcomed :raised_hands:!<br />
The most basic way to show your support is to star :star2: the project, or to raise issues :speech_balloon:<br />
But we're not gonna lie to each other, I'd rather you buy me a beer or two :beers:!

[![Paypal](.res/paypal.png)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=YCXXELQ7WCBMA)

## License

MIT. See `LICENSE` for more details.
