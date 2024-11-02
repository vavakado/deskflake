{
  pkgs,
  lib,
  ...
}:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "vavakado";
  home.homeDirectory = "/home/vavakado";

  home.stateVersion = "24.11"; # don't change it bro

  gtk.enable = true;
  gtk.cursorTheme.package = pkgs.google-cursor;
  gtk.cursorTheme.name = "GoogleDot-White";
  gtk.theme.package = pkgs.tokyonight-gtk-theme;
  gtk.theme.name = "Tokyonight-Dark";
  gtk.iconTheme.package = pkgs.adwaita-icon-theme;
  gtk.iconTheme.name = "Adwaita";

  programs = {
    #    direnv = {
    #      enable = true;
    #      enableBashIntegration = true; # see note on other shells below
    #      nix-direnv.enable = true;
    #    };
    #
    neovim = {
      enable = true;
      extraLuaPackages = luaPkgs: with luaPkgs; [ magick ];
      extraPackages = [ pkgs.imagemagick ];
      extraWrapperArgs = [
        "--suffix"
        "LIBRARY_PATH"
        ":"
        "${lib.makeLibraryPath [
          pkgs.stdenv.cc.cc
          pkgs.zlib
        ]}"
        "--suffix"
        "PKG_CONFIG_PATH"
        ":"
        "${lib.makeSearchPathOutput "dev" "lib/pkgconfig" [
          pkgs.stdenv.cc.cc
          pkgs.zlib
        ]}"
      ];
    };

    #    bash = {
    #      shellAliases = {
    #        ".." = "cd ..";
    #        v = "nvim";
    #      };
    #      enable = true; # see note on other shells below
    #    };
    #    zoxide = {
    #      enable = true;
    #      enableBashIntegration = true;
    #    };
    #    eza = {
    #      enable = true;
    #      icons = true;
    #    };
    #    starship = {
    #      enable = true;
    #      enableBashIntegration = true;
    #    };

    # ags = {
    #   enable = true;
    #
    #   # null or path, leave as null if you don't want hm to manage the config
    #   configDir = null;
    #
    #   # additional packages to add to gjs's runtime
    #   extraPackages = with pkgs; [ sass ];
    # };
    zathura = {
      enable = true;
      options = {
        selection-clipboard = "clipboard";
        default-bg = "#1a1b26";
        default-fg = "#a9b1d6";
        statusbar-fg = "#a9b1d6";
        statusbar-bg = "#24283b";
      };
    };

    home-manager.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  #  home.sessionVariables = { EDITOR = "nvim"; };
  # home.sessionPath = [ "$HOME/.cargo/bin" ];
  home.packages = with pkgs; [
    bc
    gallery-dl
    gdu
    hugo
    irssi
    libnotify
    lua51Packages.lua
    lua51Packages.luarocks
    profanity
    swww
    tabby-agent
    tor-browser
    vscode
    wofi-emoji
    yazi

    hypridle
    hyprlock

    elixir
    elixir-ls
    inotify-tools
    lexical
    postgresql
  ];
}
