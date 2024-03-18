#!/bin/bash
set -e
list="$(cat qt-modules.list)"
project="$(pwd)"
for pkg in $list;do
    echo "$pkg"
    cd "$project"
    mkdir -p "linglong/sources/.build_cache/$pkg/"
    cd "linglong/sources/.build_cache/$pkg/"
    qmake -makefile PREFIX="${PREFIX}" LIB_INSTALL_DIR="${PREFIX}/lib/${TRIPLET}" "../../$pkg" && make -j8 && make install
done;