#!/bin/sh
mkdir -p "$1/uploaded"
rsync -va \
  --exclude install.sh \
  . "$1"
