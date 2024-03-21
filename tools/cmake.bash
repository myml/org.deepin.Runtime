#!/bin/bash
set -e
project="$(pwd)"
while IFS= read -r pkg; do
    echo "build $pkg"
    cd "$project"
    rm -r "linglong/sources/.build_cache/$pkg"
    mkdir -p "linglong/sources/.build_cache/$pkg"
    cd "linglong/sources/$pkg"
    cmake -B "../.build_cache/$pkg" -DCMAKE_VERBOSE_MAKEFILE=ON -DCMAKE_EXPORT_COMPILE_COMMANDS=1 \
     -DBUILD_EXAMPLES=OFF -DBUILD_DOCS=OFF -DVERSION=5.15.7.1 \
     -DCMAKE_INSTALL_PREFIX=${PREFIX} \
     -DCMAKE_INSTALL_LIBDIR=lib/${TRIPLET}
    cmake --build "../.build_cache/$pkg" -- "-j$JOBS"
    cmake --build "../.build_cache/$pkg" --target install
done;