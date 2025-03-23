{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  # TODO: remove this shit
  tailwindcss-language-serverOverride = pkgs.tailwindcss-language-server.overrideAttrs (prev: {
    installPhase = ''
      runHook preInstall

      mkdir -p $out/{bin,lib/tailwindcss-language-server}
      cp -r {packages,node_modules} $out/lib/tailwindcss-language-server
      chmod +x $out/lib/tailwindcss-language-server/packages/tailwindcss-language-server/bin/tailwindcss-language-server
      ln -s $out/lib/tailwindcss-language-server/packages/tailwindcss-language-server/bin/tailwindcss-language-server $out/bin/tailwindcss-language-server

      runHook postInstall
    '';
  });
in
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
      initExtra = ''
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
    cmake
    conda
    darktable
    delta
    digikam
    gallery-dl
    gdu
    gimp
    gjs
    glances
    gocryptfs
    graphviz
    inkscape
    irssi
    libnotify
    libreoffice
    libtool
    lftp
    graphviz
    ab-av1
    lua51Packages.lua
    finamp
    lua51Packages.luarocks
    neovide
    obsidian
    python3
    swww
    tmuxinator
    tor-browser
    vscode
    wofi-emoji
    yazi
    zk
    cool-retro-term
    tk
    hugin
    enblend-enfuse
    parallel

    hypridle
    hyprlock

    elixir
    elixir-ls
    inotify-tools
    tailwindcss-language-serverOverride
    lexical
    postgresql
    nodePackages.browser-sync
    difftastic
    gtranslator

    godot_4
    gdtoolkit_4

    jetbrains.datagrip

    # WEIRD SHIT
    sbcl
    clisp
    ((emacsPackagesFor emacs30-pgtk).emacsWithPackages (epkgs: [
      epkgs.vterm
    ]))

    #scala
    # scala
    # sbt
    # scala-cli
    # metals
    # openjdk21
    # ammonite
    # scalafmt

    #haskell
    ghc
    haskell-language-server
    stack
    cabal-install

  ];
}
