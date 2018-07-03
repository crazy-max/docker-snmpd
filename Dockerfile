FROM alpine:3.7
MAINTAINER CrazyMax <crazy-max@users.noreply.github.com>

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="snmpd" \
  org.label-schema.description="SNMP daemon image based on Alpine Linux" \
  org.label-schema.version=$VERSION \
  org.label-schema.url="https://github.com/crazy-max/docker-snmpd" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/crazy-max/docker-snmpd" \
  org.label-schema.vendor="CrazyMax" \
  org.label-schema.schema-version="1.0"

ENV SNMPD_VERSION="5.7.3"

ADD patchs /tmp/

RUN apk add --update --no-cache \
    curl \
    perl \
    perl-net-snmp \
    tzdata \
  && apk --update --no-cache add -t build-dependencies \
    build-base \
    file \
    grep \
    perl-dev \
    libressl-dev \
    linux-headers \
    zlib-dev \
  && cd /tmp \
  && curl -L http://downloads.sourceforge.net/project/net-snmp/net-snmp/${SNMPD_VERSION}/net-snmp-${SNMPD_VERSION}.tar.gz -o net-snmp-${SNMPD_VERSION}.tar.gz \
  && tar zxf net-snmp-${SNMPD_VERSION}.tar.gz \
  && cd net-snmp-${SNMPD_VERSION} \
  && patch -p1 < ../netsnmp-swinst-crash.patch \
  && patch -p1 < ../fix-includes.patch \
  && patch -p1 < ../CVE-2015-5621.patch \
  && patch -p1 < ../remove-U64-typedef.patch \
  && patch -p1 < ../fix-Makefile-PL.patch \
  && echo "Replace /proc with /hostproc in:" \
  && grep -lr '"/proc' * | while read line; do echo "  - $line" && sed -i 's@"/proc@"/hostproc@g' $line; done \
  && ./configure --prefix=/usr/local --disable-ipv6 --with-defaults \
  && make \
  && make install \
  && ln -s /usr/local/net-snmp/bin/* /usr/local/bin/ \
  && apk del build-dependencies \
  && rm -rf /tmp/* /var/cache/apk/*

ADD assets /

EXPOSE 161/udp

CMD [ "/usr/local/sbin/snmpd", "-f", "-Lo", "-c", "/etc/snmpd.conf" ]
