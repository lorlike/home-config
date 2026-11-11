# 桌面主机（本机 Arch / 笔记本）：基础配置 + 图形界面层。
{
  ...
}: {
  imports = [
    ../home.nix
    ../config/desktop
  ];

  # agenix 的密钥按主机公钥加密，见 secrets/secrets.nix
  age.secrets.apikey.file = ../secrets/apikey.age;
}
