{ pkgs, inputs, ... }: {
  programs.spicetify =
    let spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle # shuffle+ (special characters are sanitized out of extension names)
        fullAppDisplay
        autoVolume
        copyToClipboard
        betterGenres
        fullScreen
        beautifulLyrics
      ];
      theme = spicePkgs.themes.text;
      colorScheme = "TokyoNight";
    };
}
