#!/bin/sh
set -e
docker build -t secp256k1 .
rm -rf dist.docker
docker cp $(docker create --name=secp256k1 secp256k1):/usr/local ./dist.docker
docker rm secp256k1
