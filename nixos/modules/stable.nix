{ inputs, system, ... }:
{
  environment.systemPackages = with inputs.nixpkgs-stable.legacyPackages."${system}"; [ pix ];
}
