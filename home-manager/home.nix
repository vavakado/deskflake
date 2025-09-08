{
  pkgs,
  lib,
  config,
  ...
}:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "vavakado";
  home.homeDirectory = "/home/vavakado";

  home.stateVersion = "24.11"; # don't change it bro

  # qt = {
  #   enable = true;
  #   platformTheme.name = "kde6";
  #   style = {
  #     name = "adwaita-dark";
  #     # package = pkgs.adwaita-qt6;
  #   };
  # };

  gtk.enable = true;
  # gtk.cursorTheme.package = pkgs.google-cursor;
  # gtk.cursorTheme.name = "GoogleDot-White";
  gtk.cursorTheme = {
    package = pkgs.apple-cursor;
    name = "macOS";
  };
  gtk.theme.package = pkgs.whitesur-gtk-theme;
  gtk.theme.name = "WhiteSur-Dark";
  gtk.iconTheme.package = pkgs.adwaita-icon-theme;
  gtk.iconTheme.name = "Adwaita";

  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };

    neovim = {
      enable = true;
      extraLuaPackages = luaPkgs: with luaPkgs; [ magick ];
      extraPackages = [
        pkgs.imagemagick
        pkgs.inotify-tools
      ];
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

    bash = {
      shellAliases = {
        ".." = "cd ..";
        la = "eza --icons --all";
        ll = "eza --icons --long";
        ls = "eza --icons";
        lw = "eza --icons --long --sort changed";
        v = "nvim";
      };
      bashrcExtra = ''
                calc() {
                    echo "scale=4; $*" | bc -l
                }
        function y() {
        	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        	yazi "$@" --cwd-file="$tmp"
        	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        		builtin cd -- "$cwd"
        	fi
        	rm -f -- "$tmp"
        }
      '';
      historySize = 100000;
      historyFileSize = 300000;
      enable = true; # see note on other shells below
    };
    zsh = {
      enable = true;
      shellAliases = {
        ".." = "cd ..";
        la = "eza --icons --all";
        ll = "eza --icons --long";
        ls = "eza --icons";
        lw = "eza --icons --long --sort changed";
        v = "nvim";
      };
      autosuggestion = {
        enable = true;
        strategy = [
          "match_prev_cmd"
          "completion"
          "history"
        ];
      };
      syntaxHighlighting.enable = true;
      dotDir = config.xdg.configHome + "/zsh";
      history = {
        save = 300000;
        size = 100000;
      };
      initContent = ''
        any-nix-shell zsh | source /dev/stdin
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word

        function y() {
        	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        	yazi "$@" --cwd-file="$tmp"
        	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        		builtin cd -- "$cwd"
        	fi
        	rm -f -- "$tmp"
        }


        open() {
        	("$@" &)
        }
      '';
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
    eza = {
      enable = true;
      icons = "auto";
      package = pkgs.eza.overrideAttrs (oldAttrs: {
        patches = [ ./blip-icon.patch ];
      });
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

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

    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    home-manager.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };
  home.sessionPath = [
    "$HOME/.cargo/bin"
    "$HOME/go/bin/"
    "$HOME/.local/bin"
    "$HOME/.config/emacs/bin"
  ];

  home.packages = with pkgs; [
    any-nix-shell
    chromium
    cliphist
    delta
    difftastic
    digikam
    enblend-enfuse
    gallery-dl
    gdu
    graphviz
    harper # spellcheck
    hugin
    hypridle
    hyprlock
    hyprpaper
    hyprsunset
    inkscape
    krita
    lazysql
    libreoffice
    lua51Packages.lua
    lua51Packages.luarocks
    neovide
    nixpkgs-review
    parallel
    pnpm
    vscode
    wofi-emoji
    yazi
    yt-dlp
    hyfetch
    exiftool
    dysk
    swww
    hyprshade
    tmuxinator
    calibre
    comma
    gimp3
    pandoc
    hyperfine
    file
    patchelf
    thunderbird-bin
    # godot_4
    hunspell
    hunspellDicts.en_US-large
    hunspellDicts.ru_RU
    hunspellDicts.he-il
    hunspellDicts.tok
    zenity
    fennel
    gajim
    distrobox
    tetex
    blahaj
    uutils-coreutils-noprefix
    kondo
    python3
    tree-sitter
    komikku
    kcov
    vtsls

    aseprite

    elixir-ls
    ((emacsPackagesFor emacs30-pgtk).emacsWithPackages (epkgs: [
      epkgs.vterm
    ]))

  ];
}
