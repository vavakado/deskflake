{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lix-module = {
      url =
        "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, lix-module, ... }@inputs:
    let system = "x86_64-linux";
    in {
      nixosConfigurations = {
        uwuw = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit self system;
            inherit inputs;
          };
          modules = [ ./configuration.nix lix-module.nixosModules.default ];
        };
      };
    };
}
