{pkgs, ...}: {
  imports = [
    ./starship.nix
    ./fish
    ./yazi
    ./zoxide.nix
  ];
  home.packages = with pkgs; [
    fzf
  ];
}
