#!/bin/bash
set -e
project="$(pwd)"
while IFS= read -r pkg; do
    echo "build $pkg"
    cd "$project"
    rm -r "linglong/sources/.build_cache/$pkg"
    mkdir -p "linglong/sources/.build_cache/$pkg"
    cd "linglong/sources/.build_cache/$pkg"
    # MIME_TYPE_FILE_INSTALL_PATH 是 qt5integration 需要用到的
    qmake -makefile PREFIX="${PREFIX}" MIME_TYPE_FILE_INSTALL_PATH="$PREFIX/share/mime/packages" LIB_INSTALL_DIR="${PREFIX}/lib/${TRIPLET}" "../../$pkg"
    make "-j$JOBS"
    make install
done;