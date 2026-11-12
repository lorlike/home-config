# home-manager 配置

同一份配置同时支持**桌面机器**和**纯 CLI 服务器**，靠模块分层来区分。

## 目录结构

```
home.nix                  # 跨主机共享：编辑器、版本控制、shell、CLI 工具
flake.nix                 # 暴露两个 homeConfiguration
hosts/
  desktop.nix             # home.nix + config/desktop
  server.nix              # 只有 home.nix
config/
  editor/                 # helix / nixvim（纯 CLI，两台机器共用）
  vcs/                    # git / jj / delta
  shell/                  # zsh / fish / starship / zoxide / yazi
  dev/                    # mise（+ zed 已移到 desktop）
  desktop/                # ★ 只在有图形界面的机器上导入
    default.nix           #   niri、字体、pigma、arcana-world、genericLinux.gpu
    session.nix           #   tty1 登录时 exec startx
    term/                 #   kitty / alacritty
    zed/                  #   zed-editor
    peripherals/          #   wifi / touchpad shell 函数（NetworkManager / xinput）
secrets/                  # 按主机公钥加密的 agenix 密钥
```

判定规则很简单：**只要跑起来需要窗口、显卡、声卡、字体渲染或实体外设，就放
`config/desktop/`。** 剩下的一律进 `home.nix` 及其 imports。

## 用法

```bash
# 桌面机器
home-manager switch --flake ~/.config/home-manager#lorlike

# 服务器
home-manager switch --flake ~/.config/home-manager#lorlike-server
```

## 服务器与桌面的差异

| 内容 | 桌面 | 服务器 |
| --- | --- | --- |
| niri / kitty / alacritty / zed-editor | ✅ | ❌ |
| Nerd Font 字体 | ✅ | ❌ |
| `targets.genericLinux.gpu` | ✅ | ❌ |
| pigma / arcana-world（需声卡、ALSA） | ✅ | ❌ |
| `exec startx`（tty1 自动启动 X） | ✅ | ❌ |
| `wifi` / `touchpad` shell 函数 | ✅ | ❌ |
| nvim `wl-copy` 剪贴板 provider | ✅ | ❌（走 OSC52） |
| nvim / helix / yazi / jj / mise / 各类 CLI | ✅ | ✅ |

服务器端实际装出的包（`nix eval` 验证过）：apache-httpd、asciinema、cachix、
delta、direnv、fastfetch、fish、fzf、git、helix、jujutsu、lazyjj、minikube、
mise、nixvim、ragenix、sqlmux、starship、trashy、uv、wrk、yazi、zsh…
没有 niri / kitty / alacritty / zed-editor / pigma / arcana-world / 字体 /
non-nixos-gpu。

## 服务器首次部署

1. 在服务器上生成 age 公钥：

   ```bash
   nix shell nixpkgs#ssh-to-age -c sh -c \
     'cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age'
   # 若使用用户密钥：
   nix shell nixpkgs#ssh-to-age -c ssh-to-age < ~/.ssh/id_ed25519.pub
   ```

2. 把得到的 `age1...` 加进 `secrets/secrets.nix` 的 `systems` 列表。
3. 在**已有密钥的机器**上重新加密：`agenix -r`。
4. 服务器上打开 `hosts/server.nix` 里被注释的

   ```nix
   age.secrets.apikey.file = ../secrets/apikey.age;
   ```

5. `home-manager switch --flake .#lorlike-server`

未完成第 2～4 步时，服务器配置**不会**引用 agenix 密钥，shell 初始化脚本也用
`[ -r ... ]` 做了保护，所以激活不会因为缺密钥而失败。
