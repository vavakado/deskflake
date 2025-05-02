{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    nixpkgs-my-fork.url = "github:vavakado/nixpkgs?ref=toggle-openusd-blender";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags.url = "github:Aylur/ags";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    umu = {
      url = "git+https://github.com/Open-Wine-Components/umu-launcher/?dir=packaging\/nix&submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hinoirisetr = {
      url = "git+https://git.vavakado.xyz/vavakado/hinoirisetr";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    menucalc.url = "github:sumnerevans/menu-calc";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixpkgs-my-fork,
      hinoirisetr,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      forkedPkgs = import nixpkgs-my-fork {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      overlay = final: prev: {
        blender = forkedPkgs.blender.override {
          cudaSupport = true;
          openUsdSupport = false;
        };
      };
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
              { ... }:
              {
                nixpkgs.overlays = [ overlay ];
                nixpkgs.config.allowUnfree = true;
              }
            )
            (
              { inputs, system, ... }:
              {
                environment.systemPackages = [
                  inputs.hinoirisetr.packages.${system}.default
                ];
              }
            )
            ./configuration.nix
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
          inputs.ags.homeManagerModules.default
        ];
      };
    };
}
