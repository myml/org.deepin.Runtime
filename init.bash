#!/bin/bash
set -e    
# 安装qbase构建依赖
bash tools/deb-source.bash linglong/pool "$PREFIX"
# 配置环境变量
export PATH=$PATH:$PREFIX/bin
export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig:$PREFIX/lib/x86_64-linux-gnu/pkgconfig:$PREFIX/share/pkgconfig:$PKG_CONFIG_PATH
export LIBRARY_PATH=$PREFIX/lib:$PREFIX/lib/x86_64-linux-gnu:$LIBRARY_PATH
export LD_LIBRARY_PATH=$PREFIX/lib:$PREFIX/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
RUNTIME_C_INCLUDE_PATH=/runtime/lib/gcc/x86_64-linux-gnu/8/include:/runtime/local/include:/runtime/lib/gcc/x86_64-linux-gnu/8/include-fixed:/runtime/include/x86_64-linux-gnu:/runtime/include
SYSTEM_C_INCLUDE_PATH=/usr/lib/gcc/x86_64-linux-gnu/8/include:/usr/local/include:/usr/lib/gcc/x86_64-linux-gnu/8/include-fixed:/usr/include/x86_64-linux-gnu:/usr/include

# dtk 有个错误的include <QGSettings/QGSettings> 应该写成 <QGSettings>，在新版本dtk已修复，这里先添加一个path修复
DTK_FIX_QGSETTTINGS_PATH=/runtime/include/x86_64-linux-gnu/qt5

export C_INCLUDE_PATH=$RUNTIME_C_INCLUDE_PATH:$SYSTEM_C_INCLUDE_PATH:$DTK_FIX_QGSETTTINGS_PATH

RUNTIME_CPLUS_INCLUDE_PATH=/runtime/include/c++/8:/runtime/include/x86_64-linux-gnu/c++/8
SYSTEM_CPLUS_INCLUDE_PATH=/usr/include/c++/8:/usr/include/x86_64-linux-gnu/c++/8

export CPLUS_INCLUDE_PATH=$RUNTIME_CPLUS_INCLUDE_PATH:$SYSTEM_CPLUS_INCLUDE_PATH:$C_INCLUDE_PATH
export PERL5LIB=$PREFIX/local/lib/x86_64-linux-gnu/perl/5.28.1:$PREFIX/local/share/perl/5.28.1:$PREFIX/lib/x86_64-linux-gnu/perl5/5.28:$PREFIX/share/perl5:$PREFIX/lib/x86_64-linux-gnu/perl/5.28:$PREFIX/share/perl/5.28:$PREFIX/local/lib/site_perl:$PREFIX/lib/x86_64-linux-gnu/perl-base
