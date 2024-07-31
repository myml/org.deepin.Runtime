#!/bin/bash
set -e
# qt 模块
modules=(
qtbase-opensource-src
qtsvg-opensource-src
qtdeclarative-opensource-src
qtgraphicaleffects-opensource-src
qtquickcontrols-opensource-src
qtquickcontrols2-opensource-src
qtimageformats-opensource-src
qtmultimedia-opensource-src
qtspeech-opensource-src
qttools-opensource-src
qtx11extras-opensource-src
qtwayland-opensource-src
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