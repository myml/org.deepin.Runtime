#!/bin/bash
set -e
poolURL=http://10.20.64.92:8080/testing25_daily/pool
codename=main
sources=(
    qt6-base
    qt6-svg
    qt6-declarative
    qt6-imageformats
    qt6-multimedia
    qt6-speech
    qt6-tools
    qt6-wayland
    qt6-translations
    qt6-5compat
)
sources+=(
    dtk6core
    dtk6declarative
    dtk6gui
    dtk6widget
    dtk6log
    dde-qt6platform-plugins
    qt6integration
    fcitx5-qt
)

# 兼容旧版本runtime
sources+=(
    icu
    xcb-util
    libpciaccess
)

# 解决功能问题
sources+=(
    # 解决 ctrl+shift+? 快捷键对话框
    # deepin-shortcut-viewer
)
rm install.list.tmp || true
for src in "${sources[@]}"; do
    echo "Source $src" >&2
    dir=${src:0:1}
    if [[ $src == lib* ]]; then
        dir=${src:0:4}
    fi
    out=$(curl -q -f "$poolURL/$codename/$dir/$src/" 2>/dev/null | grep deb | awk -F'_' '{print $1}' | awk -F'"' '{print $2}' | uniq)
    echo "  # source package $src" >>install.list.tmp
    for pkg in $(echo "$out" | grep -v 'dbgsym$' | grep -v '\-doc$' | grep -v '\-examples$' | grep -v '\-doc\-'); do
        echo "  Binary $pkg" >&2
        echo "  # linglong:gen_deb_source install $pkg" >>install.list.tmp
    done
done

sed -i '/libfcitx5-qt1/d' install.list.tmp
sed -i '/libfcitx5-qt-dev/d' install.list.tmp
sed -i '/fcitx5-frontend-qt5/d' install.list.tmp

for file in linglong.yaml arm64/linglong.yaml loong64/linglong.yaml sw64/linglong.yaml; do
    grep -B 1000 'linglong:gen_deb_source sources' $file >$file.bk
    cat install.list.tmp >>$file.bk
    mv $file.bk $file
done

rm install.list.tmp
