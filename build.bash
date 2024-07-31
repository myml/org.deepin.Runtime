#!/bin/bash
set -e
set -o pipefail
# 开始构建
./modules.list.sh | while IFS= read -r pkg
do
    # 单独的构建脚本
    if [ -e "./tools/$pkg.bash" ]; then
        echo "$pkg" "./tools/$pkg.bash"
        ./tools/$pkg.bash 2>&1 | tee "logs/$pkg.log"
    # 通用的cmake构建脚本
    elif ls linglong/sources/$pkg | grep -q ^CMakeLists.txt$; then
        echo "$pkg" ./tools/cmake.bash
        echo "$pkg" | ./tools/cmake.bash 2>&1 | tee "logs/$pkg.log"
    # 通用的qmake构建脚本
    elif ls linglong/sources/$pkg | grep -q .pro$; then
        echo "$pkg" ./tools/qmake.bash
        echo "$pkg" | ./tools/qmake.bash 2>&1 | tee "logs/$pkg.log"
    else
        echo "Can not build $pkg"
        exit 1
    fi
done
