{
  description = "Home Manager configuration of lorlike";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "git+https://mirrors.tuna.tsinghua.edu.cn/git/nixpkgs.git?ref=nixos-unstable&shallow=1";
    home-manager = {
      url = "git+https://ghfast.top/https://github.com/nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "git+https://ghfast.top/https://github.com/nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "git+https://ghfast.top/https://github.com/ryantm/agenix";
    nixvim.url = "git+https://ghfast.top/https://github.com/nix-community/nixvim";
  };

  outputs =
    { nixpkgs, home-manager, agenix, nur, nixvim, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      username = "lorlike";

      # 所有主机共用的模块
      commonModules = [
        nur.modules.homeManager.default
        agenix.homeManagerModules.default
        nixvim.homeModules.nixvim
      ];

      mkHome = host: home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = commonModules ++ [ ./hosts/${host}.nix ];
      };
    in
    {
      # 桌面主机（带 GUI）：home-manager switch --flake .#lorlike
      homeConfigurations."${username}" = mkHome "desktop";

      # 服务器主机（纯 CLI）：home-manager switch --flake .#lorlike-server
      homeConfigurations."${username}-server" = mkHome "server";
    };
}
