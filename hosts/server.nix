# 服务器主机：只要基础配置，不导入 config/desktop（GUI / 字体 / 外设）。
#
# 与桌面主机的差异：
#   - 没有 niri / kitty / alacritty / zed-editor / 字体
#   - 没有 pigma / arcana-world（需要声卡、ALSA）
#   - 没有 exec startx（tty1 自动启动 X）
#   - 没有 wifi / touchpad shell 函数（NetworkManager / X11 外设）
#   - 没有 wl-copy 剪贴板 provider（SSH 下 nvim 走 OSC52）
#   - 关闭 GPU 驱动集成（不引入 non-nixos-gpu 包装）
{
  lib,
  ...
}: {
  imports = [
    ../home.nix
  ];

  # 默认值在 genericLinux.enable 为真时会被模块打开，headless 机器上没必要：
  # 它只影响窗口程序能否找到正确的 OpenGL / Vulkan 驱动。
  targets.genericLinux.gpu.enable = lib.mkForce false;

  # 密钥按主机公钥加密。在服务器上生成公钥后需要把它加进
  # secrets/secrets.nix 的 systems 列表并重新 agenix -r，
  # 然后打开下面这行（见 README 的说明）。
  #
  # age.secrets.apikey.file = ../secrets/apikey.age;
}
