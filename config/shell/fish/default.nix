{pkgs, ...}: {
  programs.fish = {
    enable = true;

    # 注意：这里只放跨机器通用的初始化。
    # `exec startx`（桌面会话）与 wifi/touchpad 函数分别属于
    # config/desktop/ 下的模块，服务器配置不会导入它们。
    interactiveShellInit = ''
      set -g fish_greeting ""
      source ${./config/agenix-env.fish}
      source ${./config/cargo.fish}
      source ${./config/proxy.fish}

      # 可选的外设辅助函数（wifi / touchpad），由 config/desktop/peripherals 提供
      for f in $HOME/.config/fish/peripherals/*.fish
        test -r $f; and source $f
      end
    '';
  };

  # fzf 键位绑定：Ctrl-R 反查历史 / Ctrl-T 选文件 / Alt-C 进目录
  home.packages = with pkgs; [
    # fishPlugins.fzf
    fishPlugins.bass
  ];
}
