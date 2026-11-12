{pkgs, ...}: {
  programs.zsh = {
    enable = true;

    defaultKeymap = "emacs";

    enableCompletion = true;
    autosuggestion.enable = true; # 自动建议
    fastSyntaxHighlighting.enable = true;
    historySubstringSearch.enable = true; # 历史子串搜索

    # 注意：`exec startx`（桌面会话自动启动）在 config/desktop/ 里，服务器不导入。

    plugins = [
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
      {
        name = "my-zsh-config";
        src = ./config;
        file = "init.zsh";
      }
    ];

    history = {
      size = 10000;
      save = 10000;
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
      extended = true;
      expireDuplicatesFirst = true;
    };
  };

  home.packages = with pkgs; [
    zsh-completions
    zsh-fzf-tab
  ];
}
