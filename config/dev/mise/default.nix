{config,...}:
{
  programs.mise = {
    enable = true;
    globalConfig = {
      tools = {
        node = "26";
        pnpm = "12";
        bun = "1.4";
        go = "1.27";
        java = "27";
        just = "1.59";
        cmake = "4";
      };
      env.GOPATH = "$HOME/.go";
      settings = {
        activate_aggressive = true;
        node.mirror_url = "https://npmmirror.com/mirrors/node/";
        url_replacements = {
          "https://github.com/" = "https://ghfast.top/https://github.com/";
        };
      };
    };
  };

  home.sessionPath = [
    "${config.xdg.dataHome}/pnpm/bin"
  ];
}
