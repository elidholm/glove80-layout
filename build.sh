#!/usr/bin/env bash

set -euo pipefail

image='glove80-modifier-lighting-build'
revision=$(< config/firmware-revision)

if (($# > 0)); then
  printf 'Firmware is pinned in config/firmware-revision; revision overrides are not supported.\n' >&2
  exit 1
fi

docker build --build-arg "FIRMWARE_REVISION=$revision" -t "$image" .
docker run --rm -v "$PWD:/config" -e UID="$(id -u)" -e GID="$(id -g)" "$image"
