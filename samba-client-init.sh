#!/bin/bash

set -e

# 更新软件包列表
sudo apt update

# 安装 Samba 客户端
sudo apt install -y cifs-utils

echo "Samba 客户端工具安装完成。"

# 创建凭据文件并写入用户名和密码 (覆盖模式，使用 printf)
printf "username=a1an\npassword=1314\n" | sudo tee /root/.smbcredentials

# 设置凭据文件权限，只有 root 用户可以读取
sudo chmod 600 /root/.smbcredentials

# 创建挂载点目录
sudo mkdir -p /mnt/Public

# 添加 fstab 条目，实现开机自动挂载
FSTAB_LINE="//192.168.2.3/public /mnt/Public cifs credentials=/root/.smbcredentials,uid=1000,gid=1000,_netdev,x-systemd.requires=network-online.target,x-systemd.after=network-online.target 0 0"

# 检查是否已经存在相同的 fstab 条目
if ! grep -qF "$FSTAB_LINE" /etc/fstab; then
  echo "$FSTAB_LINE" | sudo tee -a /etc/fstab
  echo "已将 fstab 条目添加到 /etc/fstab"
else
  echo "fstab 条目已存在，无需添加。"
fi

# 执行挂载命令 (可选，如果需要立即挂载)
# sudo mount -a

echo "脚本执行完成。"