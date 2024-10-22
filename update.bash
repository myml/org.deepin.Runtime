#!/bin/bash
poolURL=http://10.20.64.92:8080/testing_full_20241113/pool
codename=main
sources=(
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
sources+=(
    dtkcommon
    dtkcore
    dtkcore
    dtkdeclarative
    dtkgui
    dtkwidget
    qt5integration
    qt5platform-plugins
    dde-qt5platform-plugins
)

cat linglong.yaml | grep -B 1000 'linglong:gen_deb_source sources' >linglong.yaml.bk
cat arm64/linglong.yaml | grep -B 1000 'linglong:gen_deb_source sources' >arm64/linglong.yaml.bk
cat loong64/linglong.yaml | grep -B 1000 'linglong:gen_deb_source sources' >loong64/linglong.yaml.bk

for src in "${sources[@]}"; do
    echo "Source $src" >&2
    out=$(curl -q "$poolURL/$codename/${src:0:1}/$src/" 2>/dev/null | grep deb | awk -F'_' '{print $1}' | awk -F'"' '{print $2}' | uniq)
    for pkg in $(echo "$out" | grep -v '\-examples-dbgsym$' | grep -v '\-doc$' | grep -v '\-examples$' | grep -v '\-doc\-'); do
        echo "Binary $pkg" >&2
        echo "  # linglong:gen_deb_source install $pkg" >>linglong.yaml.bk
        echo "  # linglong:gen_deb_source install $pkg" >>arm64/linglong.yaml.bk
        echo "  # linglong:gen_deb_source install $pkg" >>loong64/linglong.yaml.bk
    done
done

mv linglong.yaml.bk linglong.yaml
mv arm64/linglong.yaml.bk arm64/linglong.yaml
mv loong64/linglong.yaml.bk loong64/linglong.yaml
