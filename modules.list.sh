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
    qtgamepad-everywhere-src
    qtsensors-opensource-src
    qtspeech-opensource-src
    qtvirtualkeyboard-opensource-src
    qtserialport-opensource-src
    qtnetworkauth-everywhere-src
    qttools-opensource-src
    qtx11extras-opensource-src
    qtwayland-opensource-src
)

# dtk 模块
modules+=(
    dtkcommon
    dtkcore
    dtkgui
    dtkwidget
)

# qt5integration
modules+=(
    googletest
    lxqt-build-tools
    libqtxdg
    qt5integration
)

for item in "${modules[@]}"; do
    echo "$item"
done