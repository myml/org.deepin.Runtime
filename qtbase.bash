#!/bin/bash
set -e
# 构建qtbase
rm -r "/project/linglong/sources/.build_cache/qtbase-opensource-src" || true
mkdir -p "/project/linglong/sources/.build_cache/qtbase-opensource-src"
cd "/project/linglong/sources/.build_cache/qtbase-opensource-src/"
/project/linglong/sources/qtbase-opensource-src/configure -prefix ${PREFIX} \
    -libdir ${PREFIX}/lib/${TRIPLET} \
    -plugindir ${PREFIX}/lib/${TRIPLET}/qt5/plugins \
    -qmldir ${PREFIX}/lib/${TRIPLET}/qt5/qml \
    -headerdir ${PREFIX}/include/${TRIPLET}/qt5 \
    -datadir ${PREFIX}/share/qt5 \
    -translationdir ${PREFIX}/share/qt5/translations \
    -archdatadir ${PREFIX}/lib/${TRIPLET}/qt5 \
    -sysconfdir ${PREFIX}/etc/xdg \
    -docdir ${PREFIX}/share/qt5/doc \
    -importdir ${PREFIX}/lib/${TRIPLET}/qt5/imports \
    -hostdatadir ${PREFIX}/lib/${TRIPLET}/qt5 \
    -confirm-license \
    -opensource \
    -plugin-sql-odbc \
    -plugin-sql-psql \
    -plugin-sql-sqlite \
    -no-sql-sqlite2 \
    -plugin-sql-tds \
    -system-sqlite \
    -platform linux-g++ \
    -system-harfbuzz \
    -system-zlib \
    -system-libpng \
    -system-libjpeg \
    -system-doubleconversion \
    -system-pcre \
    -openssl \
    -no-rpath \
    -verbose \
    -optimized-qmake \
    -dbus-linked \
    -no-strip \
    -no-separate-debug-info \
    -qpa xcb \
    -xcb \
    -glib \
    -icu \
    -accessibility \
    -nomake examples \
    -no-directfb \
    -no-use-gold-linker \
    -opengl desktop

make -j8
make install
