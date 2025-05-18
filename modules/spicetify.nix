{ pkgs, inputs, ... }:
{
  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in
    {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        # adblock
        # autoVolume
        # copyToClipboard
        # fullScreen
        # hidePodcasts
        # powerBar
        shuffle # shuffle+ (special characters are sanitized out of extension names)
        beautifulLyrics
        betterGenres
      ];
      theme = spicePkgs.themes.orchis;
      colorScheme = "DarkGreen";
    };
}
