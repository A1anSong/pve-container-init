# pve-container-init

这个仓库包含一个用于 Proxmox VE (PVE) 容器初始化的脚本 `init.sh`。

## 使用说明

你可以使用以下命令，在 PVE 容器中直接下载并执行 `init.sh` 脚本：

```bash
bash -c "$(wget -qO- https://raw.githubusercontent.com/A1anSong/pve-container-init/main/init.sh)"
```

或者使用 curl:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/A1anSong/pve-container-init/main/init.sh)"
```

## Samba 服务器初始化

使用以下命令初始化 Samba 服务器：

```bash
bash -c "$(wget -qO- https://raw.githubusercontent.com/A1anSong/pve-container-init/main/samba-server-init.sh)"
```

或者使用 curl:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/A1anSong/pve-container-init/main/samba-server-init.sh)"
```

## Samba 客户端初始化

使用以下命令初始化 Samba 客户端：

```bash
bash -c "$(wget -qO- https://raw.githubusercontent.com/A1anSong/pve-container-init/main/samba-client-init.sh)"
```

或者使用 curl:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/A1anSong/pve-container-init/main/samba-client-init.sh)"
```