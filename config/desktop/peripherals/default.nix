# 依赖实体外设 / 桌面会话的 shell 辅助函数。
#
#   wifi.fish     -> 需要无线网卡 + NetworkManager
#   touchpad.fish -> 需要触摸板 + xinput(X11)
#
# shell 模块只负责在初始化时 source 这里的文件；文件是否存在由本模块决定，
# 因此服务器（hosts/server.nix）不导入本模块时，fish 仍然能正常启动。
{
  xdg.configFile = {
    "fish/peripherals/wifi.fish".source = ./wifi.fish;
    "fish/peripherals/touchpad.fish".source = ./touchpad.fish;
  };
}
