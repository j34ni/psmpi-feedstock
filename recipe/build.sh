#!/bin/bash

set -ex

export CC=$(basename "$CC")
export CXX=$(basename "$CXX")
export FC=$(basename "$FC")

cd $SRC_DIR/psmpi

./autogen.sh

mkdir -p build
cd build

# Preset Autoconf cache variables for pscom file checks using relative paths
export ac_cv_file_configure_ac=yes
export ac_cv_file_scripts_build_allin_sh=yes

../configure --prefix=$PREFIX \
             --build=${BUILD} \
             --host=${HOST} \
             --with-confset=gcc \
             --enable-confset-overwrite \
             --with-pscom-allin=$SRC_DIR/pscom \
             --with-hwloc=$PREFIX \
             --with-pmix=$PREFIX \
             --enable-msa-awareness \
             --enable-threading

make -j"${CPU_COUNT}"

make install
