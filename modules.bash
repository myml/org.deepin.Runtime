#!/bin/bash
set -e

./modules.list.sh | while IFS= read -r pkg 
do
    if ls linglong/sources/$pkg | grep -q .pro$; then
        echo "$pkg" ./tools/qmake.bash
        echo "$pkg" | ./tools/qmake.bash
    elif ls linglong/sources/$pkg | grep -q ^CMakeLists.txt$; then
        echo "$pkg" ./tools/cmake.bash
        echo "$pkg" | ./tools/cmake.bash
    else
        echo "Can not build $pkg"
        exit 1
    fi
done