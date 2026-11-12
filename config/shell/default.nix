{pkgs, ...}: {
  imports = [
    ./starship.nix
    # 同一时间只启用一个 shell：现在用 fish。
    # 想换回 zsh 就把下面 ./zsh 解开、把 ./fish 注释掉。
    # ./zsh
    ./fish
    ./yazi
    ./zoxide.nix
  ];
  home.packages = with pkgs; [
    fzf
  ];
}
