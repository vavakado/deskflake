{ inputs, system, ... }:
{

  environment.systemPackages = with inputs.nixpkgs-my-fork.legacyPackages."${system}"; [

    (blender.override {
      cudaSupport = true;
      openUsdSupport = false;
    })
    # calibre
    # anki
    # blender
    # jellyfin-mpv-shim
    # mpv-shim-default-shaders
    # poedit
  ];
}
