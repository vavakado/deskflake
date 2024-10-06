{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, zen-browser, spicetify-nix, ... }@inputs:
    let system = "x86_64-linux";
    in {
      nixosConfigurations = {
        uwuw = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit self system;
            inherit inputs;
          };
          modules = [ ./configuration.nix ];
        };
      };
    };
}
