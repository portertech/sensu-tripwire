#!/usr/bin/env bash

export SENSU_GO_ASSET_VERSION=$(git describe --abbrev=0 --tags)

mkdir assets/
for PLATFORM in alpine debian centos6 centos7;
do
  export SENSU_GO_ASSET_FILENAME="sensu-tripwire-${PLATFORM}_${SENSU_GO_ASSET_VERSION}_linux_amd64.tar.gz"
  docker build --no-cache --rm --build-arg "SENSU_GO_ASSET_VERSION=$SENSU_GO_ASSET_VERSION" -t sensu-tripwire-${PLATFORM}:$SENSU_GO_ASSET_VERSION -f Dockerfile.${PLATFORM} .
  docker cp -L $(docker create --rm sensu-tripwire-${PLATFORM}:$SENSU_GO_ASSET_VERSION true):/tmp/$SENSU_GO_ASSET_FILENAME ./assets/
done;

cd assets/
export SENSU_GO_CHECKSUMS_FILENAME="sensu-tripwire_${SENSU_GO_ASSET_VERSION}_sha512-checksums.txt"
if [[ $(which sha512sum) ]]; then
  sha512sum ./*.tar.gz > $SENSU_GO_CHECKSUMS_FILENAME;
elif [[ $(which shasum) ]]; then
  shasum -a 512 *.tar.gz > $SENSU_GO_CHECKSUMS_FILENAME;
fi;
