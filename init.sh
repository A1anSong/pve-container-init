#!/bin/bash

set -e

echo "Starting container initialization..."

# 移除 vim-common 和 vim-tiny
apt remove -y vim-common vim-tiny

# 更新软件包列表
apt update

# 升级软件包
apt upgrade -y

# 安装常用工具
apt install -y wget curl vim net-tools iputils-ping

# 移除不再需要的依赖包和清理缓存
apt autoremove -y
apt autoclean -y

# 设置时区为上海
timedatectl set-timezone Asia/Shanghai

# 安装中文支持
apt install -y locales fonts-noto-cjk
locale-gen zh_CN.UTF-8

# 设置系统默认语言
echo "LANG=zh_CN.UTF-8" > /etc/default/locale
update-locale LANG=zh_CN.UTF-8

# 修改 /etc/ssh/sshd_config 允许 root 远程登录
sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/^PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/^#PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/^PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config

# 提示用户确认是否重启
read -r -p "Do you want to reboot the container now? (y/N): " confirm
if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
  echo "Rebooting the system..."
  reboot
else
  echo "Rebooting SSH service..."
  systemctl restart ssh
fi

# 修改 root 用户密码 (示例，请替换为你的密码)
echo "root:1314" | chpasswd

echo "Container initialization complete."
