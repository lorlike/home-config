{ pkgs, ... }:
{
  programs.fish = {
    enable = true;

    # 导入 agenix 解密的 dotenv（secrets/apikey.age），等价于 zsh 的
    # `source $XDG_RUNTIME_DIR/agenix/apikey`
    interactiveShellInit = ''
      set -g fish_greeting ""
      source ${./config/agenix-env.fish}
      source ${./config/cargo.fish}
      source ${./config/proxy.fish}
      source ${./config/touchpad.fish}
      source ${./config/wifi.fish}
    '';

    # 对应 zsh 的 profileExtra：tty1 登录且无 DISPLAY 时自动启动 X
    loginShellInit = ''
      if not set -q DISPLAY; and test (tty) = /dev/tty1
        exec startx
      end
    '';
  };

  # fzf 键位绑定：Ctrl-R 反查历史 / Ctrl-T 选文件 / Alt-C 进目录
  home.packages = with pkgs; [
    # fishPlugins.fzf
    fishPlugins.bass
  ];
}
