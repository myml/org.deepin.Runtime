#!/bin/bash
set -e
project="$(pwd)"
while IFS= read -r pkg; do
    echo "build $pkg"
    cd "$project"
    mkdir -p "linglong/sources/.build_cache/$pkg"
    cd "linglong/sources/.build_cache/$pkg"

    qmake -makefile PREFIX="${PREFIX}" \
        LIB_INSTALL_DIR="${PREFIX}/lib/${TRIPLET}" \
        "../../$pkg"
    make "-j$JOBS"
    make install
done;