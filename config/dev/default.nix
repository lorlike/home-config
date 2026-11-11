{pkgs, ...}: {
  imports = [
    ./mise
  ];
  home.packages = with pkgs; [
    wrk
    minikube
    direnv
  ];
}
