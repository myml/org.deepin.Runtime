#!/bin/bash
set -x
set -e
t=$(date +%s)

rm -rf vscode-linglong || true
git clone https://github.com/myml/vscode-linglong.git --depth 1
cd vscode-linglong

for file in linglong.yaml arm64/linglong.yaml loong64/linglong.yaml sw64/linglong.yaml; do
    sed -i "s#version: 25.2.0.*#version: 25.2.0.$t#" ../$file
    go run ./src/tools ../$file
done
