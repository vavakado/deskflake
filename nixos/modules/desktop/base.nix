{
  imports = [
    ./hyprland.nix
    ./input.nix
    ./sound.nix
    ./themes.nix
  ];

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.dconf.enable = true;
}
