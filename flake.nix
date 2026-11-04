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
    in
    {
      homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ 
          nur.modules.homeManager.default
          ./home.nix 
          agenix.homeManagerModules.default
          nixvim.homeModules.nixvim
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
