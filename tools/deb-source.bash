# 文件名 deb-source.bash
# 包含要解压的deb目录
deb_dir="$1"
# 将deb解压到输出目录
target="$2"
# 临时目录，将内容处理后再移动到 target
out_dir=$(mktemp -d -p "$target")
# 临时文件，用于记录deb文件列表
list_file="$out_dir/deb.list"
# 创建输出目录
mkdir -p "$out_dir"
# 生成文件列表
find "$deb_dir" -type f -name "*.deb" > "$list_file"
# 遍历文件列表
while IFS= read -r file
do
    echo "$file" > /dev/stderr
    # 查找data.tar文件，文件会因为压缩格式不同，有不同的后缀，例如data.tar.xz、data.tar.gz
    data_file=$(ar -t "$file" | grep data.tar)
    # 提取data.tar文件
    ar -x "$file" "$data_file"
    # 解压data.tar文件到输出目录
    tar -xf "$data_file" -C "$out_dir"
    rm "$data_file"
done < "$list_file"

# 删除临时列表文件
rm "$list_file"
rm -rf "${out_dir:?}/usr/share/applications"* || true
# 合并bin和lib到usr下面
cp -r "$out_dir"/lib/* "$out_dir/usr/lib/" || true
cp -r "$out_dir"/bin/* "$out_dir/usr/bin/" || true

# 复制文件到真正的安装目录
cp -r "$out_dir"/usr/* "$target"
# 清理临时目录
rm -r "$out_dir"
