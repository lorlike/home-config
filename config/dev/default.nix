{ pkgs, ... }:
{
  imports = [
    ./zed
    ./mise
  ];
  home.packages = with pkgs; [
    wrk
    minikube
    direnv
  ];
}
