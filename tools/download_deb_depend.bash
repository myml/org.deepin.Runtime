#!/bin/bash
set -e
set -x
rm -rf ~/.aptly
pkgs="debhelper,default-libmysqlclient-dev,dh-exec,dpkg-dev,firebird-dev,freetds-dev,libasound2-dev,libatspi2.0-dev,libcups2-dev,libdbus-1-dev,libdouble-conversion-dev,libfontconfig1-dev,libfreetype6-dev,libgbm-dev,kfreebsd-any],libgl1-mesa-dev,libgl-dev,libgles2-mesa-dev,libgles2-dev,libglib2.0-dev,libglu1-mesa-dev,libglu-dev,libgtk-3-dev,libharfbuzz-dev,libicu-dev,libinput-dev,libjpeg-dev,libmtdev-dev,libpcre2-dev,libpng-dev,libpq-dev,libproxy-dev,libpulse-dev,libsqlite3-dev,libssl-dev,libudev-dev,libvulkan-dev,libx11-dev,libx11-xcb-dev,libxcb-icccm4-dev,libxcb-image0-dev,libxcb-keysyms1-dev,libxcb-randr0-dev,libxcb-render-util0-dev,libxcb-render0-dev,libxcb-shape0-dev,libxcb-shm0-dev,libxcb-sync-dev,libxcb-xfixes0-dev,libxcb-xinerama0-dev,libxcb-xkb-dev,libxcb1-dev,libxext-dev,libxi-dev,libxkbcommon-dev,libxkbcommon-x11-dev,libxrender-dev,pkg-kde-tools,publicsuffix,unixodbc-dev,zlib1g-dev"
pkgs=$(echo "$pkgs" | tr ',' '|')
url=http://pools.uniontech.com/desktop-professional
distribution=eagle
components="main contrib"
arch=amd64
aptly mirror create -ignore-signatures -architectures=$arch -filter="$pkgs" -filter-with-deps linglong-download-depend $url $distribution $components
aptly mirror update -ignore-signatures linglong-download-depend
find ~/.aptly/pool -type f
mv ~/.aptly/pool build/pool