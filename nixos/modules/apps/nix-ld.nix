{ pkgs, ... }:
{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    avahi
    xcbuild
    icu
    libadwaita

    xorg.libX11
    libjack2
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi
    xorg.libxcb
    libxkbcommon
    libGL
    harfbuzz
    libplist
    portaudio
    kdePackages.qtbase
    lzo

    nss
    libimobiledevice
  ];
}
