# version 1.6.5-3
# docker-version 1.16.1
FROM alpine:3.5
MAINTAINER Jacek Nakonieczny <jacek.nakonieczny@gmail.com>

ENV ZNC_VERSION 1.6.5

# install build packages
RUN apk add --no-cache --virtual=build-dependencies \
  autoconf \
  automake \
  c-ares-dev \
  curl \
  cyrus-sasl-dev \
  g++ \
  gcc \
  gettext-dev \
  git \
  icu-dev \
  make \
  openssl-dev \
  perl-dev \
  python3-dev \
  swig \
  tar \
  tcl-dev

ADD docker-install.sh /install.sh
CMD ["./install.sh"]

RUN apk del --purge \
  build-dependencies

RUN adduser -D znc
ADD docker-entrypoint.sh /entrypoint.sh
ADD znc.conf.default /znc.conf.default
RUN chmod 644 /znc.conf.default

VOLUME /znc-data

EXPOSE 6667
ENTRYPOINT ["/entrypoint.sh"]
CMD [""]