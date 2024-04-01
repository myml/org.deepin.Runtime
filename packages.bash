#!/bin/bash
set -e

grep ^Package: "linglong/sources/qtbase-opensource-src/debian/control"
./modules.list.sh | while IFS= read -r pkg 
do
    grep ^Package: "linglong/sources/$pkg/debian/control"
done