#!/bin/bash

cat <(echo "qtbase-opensource-src") qt-modules.list dtk-modules.list |
 xargs -i apt showsrc {} 2>/dev/null |
 grep Build-Depends: |
 sed "s#Build-Depends:##" | # 去掉 Build-Depends:
 sed "s#,#\n#g" | # 展开列为行
 awk '{print $1}' | # 只保留包名
 sort |
 uniq |
 xargs echo