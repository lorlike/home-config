{pkgs,...}:
{
  imports = [
    ./alacritty.nix
    ./kitty.nix
  ];
  home.packages = with pkgs; [
    asciinema
    fastfetch
  ];
}
