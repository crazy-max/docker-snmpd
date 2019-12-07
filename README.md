<p align="center"><a href="https://github.com/crazy-max/docker-snmpd" target="_blank"><img height="128" src="https://raw.githubusercontent.com/crazy-max/docker-snmpd/master/.res/docker-snmpd.jpg"></a></p>

<p align="center">
  <a href="https://github.com/crazy-max/docker-snmpd/actions?workflow=build"><img src="https://github.com/crazy-max/docker-snmpd/workflows/build/badge.svg" alt="Build Status"></a>
  <a href="https://hub.docker.com/r/crazymax/snmpd/"><img src="https://img.shields.io/docker/stars/crazymax/snmpd.svg?style=flat-square" alt="Docker Stars"></a>
  <a href="https://hub.docker.com/r/crazymax/snmpd/"><img src="https://img.shields.io/docker/stars/crazymax/snmpd.svg?style=flat-square" alt="Docker Stars"></a>
  <a href="https://hub.docker.com/r/crazymax/snmpd/"><img src="https://img.shields.io/docker/pulls/crazymax/snmpd.svg?style=flat-square" alt="Docker Pulls"></a>
  <a href="https://www.codacy.com/app/crazy-max/docker-snmpd"><img src="https://img.shields.io/codacy/grade/0c877ee889a34aa790e41e21b1a44dcf.svg?style=flat-square" alt="Code Quality"></a>
  <br /><a href="https://github.com/sponsors/crazy-max"><img src="https://img.shields.io/badge/sponsor-crazy--max-181717.svg?logo=github&style=flat-square" alt="Become a sponsor"></a>
  <a href="https://www.paypal.me/crazyws"><img src="https://img.shields.io/badge/donate-paypal-00457c.svg?logo=paypal&style=flat-square" alt="Donate Paypal"></a>
</p>

## :warning: Abandoned project

This project is not maintained anymore and is abandoned. Feel free to fork and make your own changes if needed.

## About

🐳 [SNMP daemon (snmpd)](http://www.net-snmp.org/) Docker image based on Alpine Linux.<br />
If you are interested, [check out](https://hub.docker.com/r/crazymax/) my other 🐳 Docker images!

💡 Want to be notified of new releases? Check out 🔔 [Diun (Docker Image Update Notifier)](https://github.com/crazy-max/diun) project!

## Features

* SNMP daemon patched to be able to monitor on CoreOS (use `/rootfs/{dev|etc|proc|sys}`)
* Fix [CVE-2015-5621](https://nvd.nist.gov/vuln/detail/CVE-2015-5621)
* IPv6 disabled

## Ports

* `161/udp` : snmpd UDP listen port

## Usage

> :warning: snmpd has been patched to use ` /rootfs/{dev|etc|proc|sys}`.

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
  -v /:/rootfs:ro \
  -v /etc/localtime:/etc/localtime:ro \
  crazymax/snmpd:latest
```

You can also mount your own `snmpd.conf` :

```bash
$ docker run -d --name snmpd \
  --privileged \
  -p 161:161/udp \
  -v /:/rootfs:ro \
  -v /etc/localtime:/etc/localtime:ro \
  -v $(pwd)/snmpd.conf:/etc/snmpd.conf \
  crazymax/snmpd:latest
```

## Notes

If you've got the following error :

```
Cannot statfs /rootfs/proc/sys/fs/binfmt_misc: Symbolic link loop
```

Restart this service :

```
systemctl restart proc-sys-fs-binfmt_misc.mount
```

## Upgrade

To upgrade, pull the newer image and launch the container :

```bash
docker-compose pull
docker-compose up -d
```

## How can I help ?

All kinds of contributions are welcome :raised_hands:! The most basic way to show your support is to star :star2: the project, or to raise issues :speech_balloon: You can also support this project by [**becoming a sponsor on GitHub**](https://github.com/sponsors/crazy-max) :clap: or by making a [Paypal donation](https://www.paypal.me/crazyws) to ensure this journey continues indefinitely! :rocket:

Thanks again for your support, it is much appreciated! :pray:

## License

MIT. See `LICENSE` for more details.
