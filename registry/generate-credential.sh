#!/usr/bin/env bash

mkdir -p ./auth
docker run \
  --entrypoint htpasswd \
  registry:2 -Bbn developer secret > ./auth/htpasswd

