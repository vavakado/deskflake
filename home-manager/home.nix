{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "vavakado";
  home.homeDirectory = "/home/vavakado";

  home.stateVersion = "24.11"; # don't change it bro

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt6;
    };
  };

  gtk.enable = true;
  # gtk.cursorTheme.package = pkgs.google-cursor;
  # gtk.cursorTheme.name = "GoogleDot-White";
  gtk.cursorTheme.package = pkgs.apple-cursor;
  gtk.cursorTheme.name = "macOS";
  gtk.theme.package = pkgs.whitesur-gtk-theme;
  gtk.theme.name = "WhiteSur-Dark";
  gtk.iconTheme.package = pkgs.whitesur-icon-theme;
  gtk.iconTheme.name = "WhiteSur";

  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };

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
      dotDir = ".config/zsh";
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
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    ags = {
      enable = true;

      # null or path, leave as null if you don't want hm to manage the config
      configDir = null;

      # additional packages to add to gjs's runtime
      extraPackages = [
        pkgs.sass
        inputs.ags.packages."x86_64-linux".hyprland
        inputs.ags.packages."x86_64-linux".mpris
        inputs.ags.packages."x86_64-linux".wireplumber
        inputs.ags.packages."x86_64-linux".tray
        inputs.ags.packages."x86_64-linux".network
        inputs.ags.packages."x86_64-linux".apps
      ];
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

    # emacs = {
    #   enable = true;
    #   package = pkgs.emacs29-pgtk;
    #   extraPackages =
    #     epkgs: with epkgs; [
    #       vterm
    #     ];
    # };

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
    (fortune.override { withOffensive = true; })
    any-nix-shell
    bc
    bun
    chromium
    cliphist
    conda
    delta
    difftastic
    digikam
    elixir
    elixir-ls
    enblend-enfuse
    filezilla
    gallery-dl
    gdu
    gjs
    gocryptfs
    graphviz
    harper # spellcheck
    hugin
    hypridle
    hyprlock
    hyprpaper
    hyprsunset
    inkscape
    inotify-tools
    krita
    lazysql
    lexical
    libreoffice
    lua51Packages.lua
    lua51Packages.luarocks
    neovide
    nixpkgs-review
    nodePackages.browser-sync
    obsidian
    parallel
    pnpm
    postgresql
    tailwindcss-language-server
    tk
    upx
    vscode
    wofi-emoji
    yazi
    yt-dlp
    zk
    twitch-tui
    hyfetch
    exiftool
    audacity
    dysk
    swww
    hyprshade
    tmuxinator
    golangci-lint
    libnotify
    calibre
    ddate
    font-manager
    comma
    gimp3
    pandoc

    # godot_4
    gdtoolkit_4

    # WEIRD SHIT
    sbcl
    clisp
    ((emacsPackagesFor emacs30-pgtk).emacsWithPackages (epkgs: [
      epkgs.vterm
    ]))

  ];
}
