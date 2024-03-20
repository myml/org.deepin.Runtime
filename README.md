tools/download_deb_depend.bash 用于在宿主机下载 deb 依赖树
tools/download_deb-source.bash 用于在宿主机下载 deb 源码
tools/deb-source.bash 用于在玲珑容器中解压 deb 包到 $PREFIX
tools/qmake.bash 用于构建 qmake 项目
tools/cmake.bash 用于构建 cmake 项目
tools/get-depends.bash 用于获取构建依赖（实验）

qtbase.bash 用于构建 qtbase
qt-module.list 是 qt 的子模块列表，可使用 tools/qmake.bash 构建
dtk-modules.list 是 dtk 模块列表，可使用 tools/cmake.bash 构建
linglong.yaml 用于生成 org.deepin.Runtime

构建步骤：

1. 下载源码

```bash
echo qtbase-opensource-src | ./tools/download_deb_source.bash
./modules.list.sh | ./tools/download_deb_source.bash
```

2. 下载构建依赖

```bash
./depend-deb-list.sh | ./tools/download_deb_depend.bash
```

3. 使用玲珑构建 runtime

```bash
ll-builder build
```
