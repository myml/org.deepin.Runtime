#!/bin/bash
set -e
# 这个脚本用于生成modules的sources列表

url=https://pools.uniontech.com/deepin-beige
distribution=beige
components="main community"

tmpdir=$(mktemp -d)
cd "$tmpdir"
# 下载Sources文件
for component in $components;do
    curl -s "$url/dists/$distribution/$component/source/Sources.gz" | gunzip >> Sources
done;

while IFS= read -r pkg; do
    # 解析Sources文件，获取pkg的存放目录
    path=$(cat Sources | grep -E "^Package:|^Version:|^Directory:" | 
        awk 'BEGIN { FS = ": " } { if ($1 == "Package") { pkg = $2 } else if ($1 == "Version") { ver = $2 } else if ($1 == "Directory" && pkg=="'$pkg'") { printf "%s/%s_%s.dsc\n",$2, pkg, ver } }')
    echo "  - kind: dsc"
    echo "    name: $pkg"
    echo "    url: $url/$path"
    echo "    digest: $(curl -s "$url/$path" | sha256sum | awk '{print $1}')"
done;

rm -r "$tmpdir"