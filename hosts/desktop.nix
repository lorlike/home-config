# 桌面主机（本机 Arch / 笔记本）：基础配置 + 图形界面层。
{
  pkgs,
  ...
}: {
  imports = [
    ../home.nix
    ../config/desktop
    ../config/editor/nixvim
  ];

  # agenix 的密钥按主机公钥加密，见 secrets/secrets.nix
  age.secrets.apikey.file = ../secrets/apikey.age;

  # sqlmux：TUI 数据库客户端，只在桌面用
  home.packages = [pkgs.nur.repos.lorlike.sqlmux];
}
