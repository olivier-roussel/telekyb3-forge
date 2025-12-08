#!/bin/sh

set -ex

autoreconf -vif

mkdir -p build && cd build

../configure --prefix=${PREFIX}

make install -j${CPU_COUNT}
