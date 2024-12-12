{ inputs, system, ... }:
{

  environment.systemPackages = with inputs.nixpkgs-stable.legacyPackages."${system}"; [
    calibre
    # anki
    # blender
    jellyfin-mpv-shim
    mpv-shim-default-shaders
    poedit
  ];
}
