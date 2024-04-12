#!/bin/bash
set -e
set -x
# 这个脚本用于从仓库下载deb源码包
# 用法 echo pkg_name | ./tools/download_deb_source.bash
# 源码会下载到 linglong/sources/pkg_name

url=https://pools.uniontech.com/deepin-beige
distribution=beige
components="main community"

mkdir -p linglong/sources || true
cd linglong/sources
workdir=$(pwd)
tmpdir=$(mktemp -d)
cd "$tmpdir"
# 下载Sources文件
for component in $components;do
    curl "$url/dists/$distribution/$component/source/Sources.gz" | gunzip >> Sources
done;

# 去掉Version中的Epoch
sed 's#Version: [0-9]:#Version: #' -i Sources

while IFS= read -r pkg; do
    # 解析Sources文件，获取pkg的存放目录
    path=$(cat Sources | grep -E "^Package:|^Version:|^Directory:" | 
        awk 'BEGIN { FS = ": " } { if ($1 == "Package") { pkg = $2 } else if ($1 == "Version") { ver = $2 } else if ($1 == "Directory" && pkg=="'$pkg'") { printf "%s/%s_%s.dsc\n",$2, pkg, ver } }')
    # 下载源码包
    dget -x -d --allow-unauthenticated "$url/$path"
    rm -r "$pkg" || true
    # 解压源码包
    filename=$(basename "$path")
    rm -r "$workdir/$pkg" || true
    dpkg-source -x --no-copy "$filename" "$workdir/$pkg"
done;

rm -r "$tmpdir"