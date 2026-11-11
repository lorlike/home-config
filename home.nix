# 跨主机共享的基础配置。
#
# 只放“任何 Linux 机器都能跑”的东西：编辑器、版本控制、shell、CLI 工具。
# 任何依赖 GUI / 显卡 / 声卡 / 外设 / 特定硬件的包都不属于这里，
# 它们分别在：
#
#   config/desktop/  图形界面、字体、终端模拟器、外设脚本（hosts/desktop.nix 导入）
#   ./secrets        按主机加密的密钥
{
  pkgs,
  ...
}: {
  imports = [
    ./config/editor
    ./config/vcs
    ./config/shell
    ./config/dev
  ];

  home.username = "lorlike";
  home.homeDirectory = "/home/lorlike";
  home.stateVersion = "26.05";

  # 任何 Linux 机器都适用的 CLI 工具
  home.packages = with pkgs; [
    ragenix
    trashy
    uv
    cachix
    lazyjj
    nur.repos.lorlike.sqlmux
    apacheHttpd
    asciinema
    fastfetch
  ];

  # 非 NixOS 主机（Arch / 服务器）靠它设置动态链接器与 XDG 搜索路径
  targets.genericLinux.enable = true;

  programs.home-manager.enable = true;
}
