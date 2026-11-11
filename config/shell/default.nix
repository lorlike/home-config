{pkgs, ...}: {
  imports = [
    ./starship.nix
    ./zsh
    ./fish
    ./yazi
    ./zoxide.nix
  ];
  home.packages = with pkgs; [
    fzf
  ];
}
