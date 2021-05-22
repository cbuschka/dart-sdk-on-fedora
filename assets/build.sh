#!/bin/bash

set -x
set -e

if [ ! -d "/build/depot_tools" ]; then
  cd /build
  git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
else
  cd /build/depot_tools
  git pull
fi
export PATH=$PATH:/build/depot_tools

mkdir -p /build/dart-sdk
cd /build/dart-sdk
fetch dart
cd /build/dart-sdk/sdk
./tools/build.py --no-goma --mode release --arch x64 create_sdk

rm -rf /output/*
cp -R out/ReleaseX64/dart-sdk /output/
