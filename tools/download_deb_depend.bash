#!/bin/bash
set -e

pkgs=$(cat /dev/stdin | sed "s#\[[^]]\+]##g" | tr ',' '|')

url=http://pools.uniontech.com/desktop-professional
distribution=eagle
components="main contrib"
arch=amd64

rm -rf ~/.aptly
aptly mirror create -ignore-signatures -architectures=$arch -filter="$pkgs" -filter-with-deps linglong-download-depend $url $distribution $components
aptly mirror update -ignore-signatures linglong-download-depend
find ~/.aptly/pool -type f
mkdir linglong || true
rm -r linglong/pool || true
mv ~/.aptly/pool linglong/pool