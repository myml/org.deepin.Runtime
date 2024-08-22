#!/bin/bash
set -e
project="$(pwd)"
while IFS= read -r pkg; do
    echo "build $pkg"
    cd "$project"
    mkdir -p "linglong/sources/.build_cache/$pkg"
    cd "linglong/sources/.build_cache/$pkg"
    cmake -DCMAKE_VERBOSE_MAKEFILE=ON -DCMAKE_EXPORT_COMPILE_COMMANDS=1 \
     -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
     -DCMAKE_INSTALL_LIBDIR="lib/${TRIPLET}" \
     -DBUILD_EXAMPLES=OFF \
     -DBUILD_DOCS=OFF \
     -DVERSION=5.6.32 \
     "../../$pkg"
    make "-j$JOBS"
    make install
done;