{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hinoirisetr = {
      url = "git+https://git.vavakado.xyz/vavakado/hinoirisetr";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ayugram-desktop = {
      type = "git";
      submodules = true;
      url = "https://github.com/ndfined-crp/ayugram-desktop/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.2-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags.url = "github:aylur/ags";
    astal.url = "github:aylur/astal";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      lix-module,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        uwuw = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit self system;
            inherit inputs;
          };
          modules = [
            (
              { inputs, system, ... }:
              {
                environment.systemPackages = [
                  inputs.hinoirisetr.packages.${system}.default
                  inputs.ayugram-desktop.packages.${system}.ayugram-desktop
                ];
              }
            )
            ./configuration.nix
            lix-module.nixosModules.default
          ];
        };
      };
      homeConfigurations.vavakado = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          inherit inputs;
        };
        modules = [
          ./home-manager/home.nix
        ];
      };
    };
}
