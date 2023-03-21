#!/bin/bash

podman run \
  --rm \
  -it \
  -u 0:0 \
  -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
  -v $(pwd)/podman-firefox:/home/firefox:Z \
  --security-opt label=disable \
  -e DISPLAY=${DISPLAY} \
  -h 'batman' \
  ghcr.io/jameseck/drac-firefox:latest
  /usr/bin/firefox \
  -no-remote
