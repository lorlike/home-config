{pkgs,...}:
{
  programs.zsh = {
    enable = true;

    defaultKeymap = "emacs";

    enableCompletion = true;
    autosuggestion.enable = true;          # 自动建议
    fastSyntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;   # 历史子串搜索

    profileExtra = ''
    if [[ -z "$DISPLAY" && "$(tty)" == "/dev/tty1" ]]; then
      exec startx
    fi
    '';

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

  home.packages = with pkgs;[
    zsh-completions
    zsh-fzf-tab
  ];
}
