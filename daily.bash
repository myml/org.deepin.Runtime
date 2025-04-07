#!/bin/bash
set -x
set -e
VERSION="$1"

rm -rf vscode-linglong || true
git clone https://github.com/myml/vscode-linglong.git --depth 1
cd vscode-linglong

for file in linglong.yaml arm64/linglong.yaml loong64/linglong.yaml sw64/linglong.yaml mips64/linglong.yaml; do
    sed -i "s#  version: .*#  version: ${VERSION}#" ../$file
    go run ./src/tools ../$file
done
