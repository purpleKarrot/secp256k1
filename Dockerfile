# syntax=docker/dockerfile:1

FROM alpine as config
COPY . /opt/secp256k1
WORKDIR /opt/secp256k1
RUN apk --update upgrade && apk add autoconf automake libtool
RUN ./autogen.sh

FROM alpine as build
COPY --from=config /opt/secp256k1 /opt/secp256k1
WORKDIR /opt/secp256k1
RUN apk --update upgrade && apk add g++ make
RUN ./configure --enable-experimental  --enable-module-extrakeys --enable-module-schnorrsig --disable-module-recovery --disable-module-ecdh --enable-tests --disable-benchmark --disable-shared && make check && make install

# Fetch, configure

FROM alpine
COPY --from=build /usr/local /usr/local
