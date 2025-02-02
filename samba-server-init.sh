#!/bin/bash

set -e

# 更新软件包列表
apt update

# 安装 Samba
apt install -y samba

# 检查并删除已存在的 [public] 段
if grep -q "^\[public\]" /etc/samba/smb.conf; then
  sed -i '/^\[public\]/,/^$/d' /etc/samba/smb.conf
fi

# 配置 Samba (请根据你的需求修改)
cat << EOF >> /etc/samba/smb.conf

[public]
        comment = Public Shared Files
        path = /srv/samba/public
        browseable = yes
        read only = no
        guest ok = no
        valid users = @users
        create mask = 0660
        directory mask = 0770
EOF

# 创建共享目录
mkdir -p /srv/samba/public
chown root:users /srv/samba/public
chmod 0770 /srv/samba/public

# 创建 Samba 用户 (请根据你的需求修改用户名和密码)
adduser a1an
#echo "1314" | passwd --stdin a1an
#echo "1314\n1314" | smbpasswd -a a1an

# 重启 Samba 服务
systemctl restart smbd
systemctl restart nmbd

echo "Samba 服务器初始化完成。共享路径: /srv/samba/public"