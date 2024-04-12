#!/bin/bash

export JOBS=8

set -e    
# 安装qbase构建依赖
bash tools/deb-source.bash linglong/pool "$PREFIX"
# 配置环境变量
export PATH=$PATH:$PREFIX/bin
export LIBRARY_PATH=$PREFIX/lib:$PREFIX/lib/${TRIPLET}
export LD_LIBRARY_PATH=$PREFIX/lib:$PREFIX/lib/${TRIPLET}

SYSTEM_PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/lib/${TRIPLET}/pkgconfig:/usr/share/pkgconfig
RUNTIME_PKG_CONFIG_PATH=/runtime/lib/pkgconfig:/runtime/lib/${TRIPLET}/pkgconfig:/runtime/share/pkgconfig
APP_PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig:$PREFIX/lib/${TRIPLET}/pkgconfig:$PREFIX/share/pkgconfig
export PKG_CONFIG_PATH=$SYSTEM_PKG_CONFIG_PATH:$RUNTIME_PKG_CONFIG_PATH:$APP_PKG_CONFIG_PATH

# dtk 有个错误的include <QGSettings/QGSettings> 应该写成 <QGSettings>，在新版本dtk已修复，这里先添加一个path修复
DTK_FIX_QGSETTTINGS_PATH=/runtime/include/${TRIPLET}/qt5
RUNTIME_C_INCLUDE_PATH=/runtime/lib/gcc/${TRIPLET}/13/include:/runtime/local/include:/runtime/lib/gcc/${TRIPLET}/13/include-fixed:/runtime/include/${TRIPLET}:/runtime/include
SYSTEM_C_INCLUDE_PATH=/usr/lib/gcc/${TRIPLET}/13/include:/usr/local/include:/usr/lib/gcc/${TRIPLET}/13/include-fixed:/usr/include/${TRIPLET}:/usr/include
export C_INCLUDE_PATH=$RUNTIME_C_INCLUDE_PATH:$SYSTEM_C_INCLUDE_PATH:$DTK_FIX_QGSETTTINGS_PATH

RUNTIME_CPLUS_INCLUDE_PATH=/runtime/include/c++/13:/runtime/include/${TRIPLET}/c++/13
SYSTEM_CPLUS_INCLUDE_PATH=/usr/include/c++/13:/usr/include/${TRIPLET}/c++/13

export CPLUS_INCLUDE_PATH=$SYSTEM_CPLUS_INCLUDE_PATH:$SYSTEM_C_INCLUDE_PATH:$RUNTIME_CPLUS_INCLUDE_PATH:$RUNTIME_C_INCLUDE_PATH
export PERL5LIB=$PREFIX/local/lib/${TRIPLET}/perl/5.28.1:$PREFIX/local/share/perl/5.28.1:$PREFIX/lib/${TRIPLET}/perl5/5.28:$PREFIX/share/perl5:$PREFIX/lib/${TRIPLET}/perl/5.28:$PREFIX/share/perl/5.28:$PREFIX/local/lib/site_perl:$PREFIX/lib/${TRIPLET}/perl-base

set +e
# pkg-config默认会去掉INCLUDE_PATH存在的值，这会导致qtbase构建gui时设置错误的QMAKE_INCDIR_OPENGL
# 尝试使用 PKG_CONFIG_ALLOW_SYSTEM_CFLAGS = 1 让 pkg-config 不移除 /usr/include ，会引起c++ include_next的问题。
# export PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1