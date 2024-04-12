#!/bin/bash
set -e
# qt 模块
modules=(
    qtsvg-opensource-src
    qtdeclarative-opensource-src
    qtgraphicaleffects-opensource-src
    qtquickcontrols-opensource-src
    qtquickcontrols2-opensource-src
    qtscript-opensource-src
    qtxmlpatterns-opensource-src
    qtimageformats-opensource-src
    qtlocation-opensource-src
    qtmultimedia-opensource-src
    qt3d-opensource-src
    qtcharts-opensource-src
    qtconnectivity-opensource-src
    qtgamepad-opensource-src
    qtsensors-opensource-src
    qtspeech-opensource-src
    qtvirtualkeyboard-opensource-src
    qtserialport-opensource-src
    qtnetworkauth-opensource-src
    qttools-opensource-src
    qtx11extras-opensource-src
    qtwayland-opensource-src
    qtwebchannel-opensource-src
    qtwebsockets-opensource-src
    qttranslations-opensource-src
)

# dtk 模块
modules+=(
    lxqt-build-tools
    libqtxdg
    dtkcommon
    dtkcore
    dtkgui
    dtkwidget
    dtkdeclarative
)

# qt5integration
modules+=(
    googletest
    qt5integration
)
modules+=(
    dde-qt5platform-plugins
)

for item in "${modules[@]}"; do
    echo "$item"
done