#!/bin/bash

set -x
set -e

if [ ! -d "/build/depot_tools" ]; then
  cd /build
  git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
  git checkout -b master -t origin/master
else
  cd /build/depot_tools
  git checkout master
  git pull
fi
export PATH=$PATH:/build/depot_tools

mkdir -p /build/dart-sdk
cd /build/dart-sdk
if [ ! -d "/build/dart-sdk/sdk" ]; then
  fetch dart
else
  gclient sync
fi
cd /build/dart-sdk/sdk
./tools/build.py --no-goma --mode release --arch x64 create_sdk

rm -rf /output/*
cp -R out/ReleaseX64/dart-sdk /output/
