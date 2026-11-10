{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./config/editor
    ./config/vcs
    ./config/term
    ./config/shell
    ./config/dev
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "lorlike";
  home.homeDirectory = "/home/lorlike";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    ragenix
    trashy
    nerd-fonts."jetbrains-mono"
    uv
    cachix
    lazyjj
    niri
    nur.repos.lorlike.pigma
    nur.repos.lorlike.arcana-world
    nur.repos.lorlike.sqlmux
    apacheHttpd
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/lorlike/etc/profile.d/hm-session-vars.sh
  #

  age.secrets.apikey.file = ./secrets/apikey.age;
  # 解密后路径：$XDG_RUNTIME_DIR/agenix/apikey

  targets.genericLinux.enable = true;
  targets.genericLinux.gpu.enable = true;

  programs.home-manager.enable = true;
}
