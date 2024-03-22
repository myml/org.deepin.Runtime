#!/bin/bash

# qtbase构建依赖
DEPENDS="debhelper (>= 11), default-libmysqlclient-dev, dh-exec, dpkg-dev (>= 1.17.14), firebird-dev, freetds-dev, libasound2-dev [linux-any], libatspi2.0-dev, libcups2-dev, libdbus-1-dev, libdouble-conversion-dev, libfontconfig1-dev, libfreetype6-dev, libgbm-dev [linux-any kfreebsd-any], libgl1-mesa-dev | libgl-dev, libgles2-mesa-dev | libgles2-dev, libglib2.0-dev, libglu1-mesa-dev | libglu-dev, libgtk-3-dev, libharfbuzz-dev (>= 1.6.0~), libicu-dev, libinput-dev [linux-any], libjpeg-dev, libmtdev-dev [linux-any], libpcre2-dev, libpng-dev, libpq-dev, libproxy-dev, libpulse-dev, libsqlite3-dev, libssl-dev, libudev-dev [linux-any], libvulkan-dev [linux-any], libx11-dev, libx11-xcb-dev, libxcb-icccm4-dev, libxcb-image0-dev, libxcb-keysyms1-dev, libxcb-randr0-dev, libxcb-render-util0-dev, libxcb-render0-dev, libxcb-shape0-dev, libxcb-shm0-dev, libxcb-sync-dev, libxcb-xfixes0-dev, libxcb-xinerama0-dev, libxcb-xkb-dev, libxcb1-dev, libxext-dev, libxi-dev, libxkbcommon-dev, libxkbcommon-x11-dev, libxrender-dev, pkg-kde-tools (>= 0.15.17~), publicsuffix, unixodbc-dev, zlib1g-dev"
# qtsvg构建依赖
DEPENDS+=", python"
# dtkcore构建依赖
DEPENDS+=", libgsettings-qt-dev, libuchardet-dev"
# dtkgui构建依赖
DEPENDS+=", libqt5xdg-dev, librsvg2-dev"

# dtkwidget构建依赖
DEPENDS+=", libxcb-util0-dev, libstartup-notification0-dev"

# dde-qt5platform-plugins构建依赖
DEPENDS+=", git,libxcb-composite0-dev,libxcb-damage0-dev"


export DEPENDS
echo "$DEPENDS"