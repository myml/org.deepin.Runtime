#!/bin/bash

export JOBS
export VERSION
export APPID
export ARCH
export TRIPLET

set -e    
# 安装qbase构建依赖
bash tools/deb-source.bash linglong/pool "$PREFIX"
# 配置环境变量
export PATH=$PATH:$PREFIX/bin
export LIBRARY_PATH=$PREFIX/lib:$PREFIX/lib/${TRIPLET}:$LIBRARY_PATH
export LD_LIBRARY_PATH=$PREFIX/lib:$PREFIX/lib/${TRIPLET}:$LD_LIBRARY_PATH

SYSTEM_PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/lib/${TRIPLET}/pkgconfig:/usr/share/pkgconfig
RUNTIME_PKG_CONFIG_PATH=/runtime/lib/pkgconfig:/runtime/lib/${TRIPLET}/pkgconfig:/runtime/share/pkgconfig
APP_PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig:$PREFIX/lib/${TRIPLET}/pkgconfig:$PREFIX/share/pkgconfig
export PKG_CONFIG_PATH=$SYSTEM_PKG_CONFIG_PATH:$RUNTIME_PKG_CONFIG_PATH:$APP_PKG_CONFIG_PATH

# dtk 有个错误的include <QGSettings/QGSettings> 应该写成 <QGSettings>，在新版本dtk已修复，这里先添加一个path修复
DTK_FIX_QGSETTTINGS_PATH=/runtime/include/${TRIPLET}/qt5
RUNTIME_C_INCLUDE_PATH=/runtime/lib/gcc/${TRIPLET}/8/include:/runtime/local/include:/runtime/lib/gcc/${TRIPLET}/8/include-fixed:/runtime/include/${TRIPLET}:/runtime/include
SYSTEM_C_INCLUDE_PATH=/usr/lib/gcc/${TRIPLET}/8/include:/usr/local/include:/usr/lib/gcc/${TRIPLET}/8/include-fixed:/usr/include/${TRIPLET}:/usr/include
export C_INCLUDE_PATH=$RUNTIME_C_INCLUDE_PATH:$SYSTEM_C_INCLUDE_PATH:$DTK_FIX_QGSETTTINGS_PATH

RUNTIME_CPLUS_INCLUDE_PATH=/runtime/include/c++/8:/runtime/include/${TRIPLET}/c++/8
SYSTEM_CPLUS_INCLUDE_PATH=/usr/include/c++/8:/usr/include/${TRIPLET}/c++/8

export CPLUS_INCLUDE_PATH=$SYSTEM_CPLUS_INCLUDE_PATH:$SYSTEM_C_INCLUDE_PATH:$RUNTIME_CPLUS_INCLUDE_PATH:$RUNTIME_C_INCLUDE_PATH
export PERL5LIB=$PREFIX/local/lib/${TRIPLET}/perl/5.28.1:$PREFIX/local/share/perl/5.28.1:$PREFIX/lib/${TRIPLET}/perl5/5.28:$PREFIX/share/perl5:$PREFIX/lib/${TRIPLET}/perl/5.28:$PREFIX/share/perl/5.28:$PREFIX/local/lib/site_perl:$PREFIX/lib/${TRIPLET}/perl-base
