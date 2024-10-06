{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  outputs = { self, nixpkgs, zen-browser, ...}@inputs: 
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
