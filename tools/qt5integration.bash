#!/bin/bash
set -e
project="$(pwd)"
pkg=qt5integration
echo "build $pkg"
cd "$project"
mkdir -p "linglong/sources/.build_cache/$pkg"
cd "linglong/sources/.build_cache/$pkg"
cmake -DCMAKE_VERBOSE_MAKEFILE=ON -DCMAKE_EXPORT_COMPILE_COMMANDS=1 \
    -DBUILD_EXAMPLES=OFF -DBUILD_DOCS=OFF -DVERSION=5.15.7.1 \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DCMAKE_INSTALL_LIBDIR="lib/${TRIPLET}" \
    -DMIME_TYPE_FILE_INSTALL_PATH="$PREFIX/share/mime/packages" \
    "../../$pkg"
make "-j$JOBS"
make install