#! /usr/bin/env bash

# Options.
SRCDIR="/tmp"

cd "${SRCDIR}" && git clone https://github.com/znc/znc.git znc-src
cd "znc-src" \
  && git checkout "tags/znc-${ZNC_VERSION}" \
  && git submodule update --init --recursive \
  && ./autogen.sh \
  && ./configure --enable-perl --enable-python --enable-tcl --enable-cyrus \
  && (make || make) \
  && make install

cd .. && rm -rf znc-src