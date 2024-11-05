{ inputs, system, ... }:
{
  environment.systemPackages = with inputs.nixpkgs-stable.legacyPackages."${system}"; [
    # calibre
    # anki
    blender # TODO: wait for https://nixpk.gs/pr-tracker.html?pr=351902 to be merged into unstable
  ];
}
