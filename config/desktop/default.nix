# 只在带图形界面的机器（本机 / 笔记本）上导入。
#
# hosts/server.nix 不引用这个目录，所以这里可以放心依赖 GUI 程序、字体、
# 声卡以及需要实体外设的脚本。
{
  pkgs,
  ...
}: {
  imports = [
    ./session.nix
    ./term
    ./zed
    ./peripherals
  ];

  home.packages = with pkgs; [
    niri # Wayland 合成器
    nur.repos.lorlike.pigma # 网易云 TUI，但需要声卡
    nur.repos.lorlike.arcana-world # TUI + TTS，链接 ALSA
    nerd-fonts."jetbrains-mono" # 终端/编辑器图标字体
  ];

  # 配置 OpenGL / Vulkan 驱动路径（non-nixos-gpu）。纯 CLI 服务器上无意义。
  targets.genericLinux.gpu.enable = true;

  # Neovim 的 +/* 寄存器接 Wayland 剪贴板（wl-clipboard）。
  # 服务器上没有 Wayland session，SSH 下走 basic.nix 里的 OSC52 分支。
  programs.nixvim.clipboard.providers.wl-copy.enable = true;
}
