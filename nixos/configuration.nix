{ pkgs, inputs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/bundle.nix
    inputs.spicetify-nix.nixosModules.default
  ];

  nix = {
    settings = {
      substituters = [
        "https://cache.nixos.org/"
        "https://cache.garnix.io"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
      trusted-users = [
        "root"
        "@wheel"
        "vavakado"
      ];
      secret-key-files = [
        "/home/vavakado/Documents/sign/cache-priv-key.pem"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    tmp.cleanOnBoot = true;
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/efi";
      };
      systemd-boot = {
        enable = true;
      };
    };
  };

  networking.hostName = "uwuw"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Asia/Jerusalem";

  environment.systemPackages = with pkgs; [
    (blender.override {
      openUsdSupport = false;
    })
    ab-av1
    anki
    bat
    btop
    chezmoi
    clang
    ddcutil
    dust
    dwarfs
    element-desktop
    fastfetch
    fd
    ffmpeg-full
    file-roller
    flite # for narrator
    glow
    gnumake
    go
    godot-mono
    grim
    imagemagick
    inputs.quickshell.packages.${pkgs.system}.default
    jellyfin-mpv-shim
    jq
    kdePackages.qt6ct
    kdePackages.qtdeclarative
    keepassxc
    kitty
    localsend
    mako
    mold
    mpv
    mpv-shim-default-shaders
    nemo-fileroller
    nemo-with-extensions
    nix-index
    nixfmt-rfc-style
    nodejs
    nvtopPackages.nvidia
    nwg-look
    onefetch
    p7zip-rar
    pavucontrol
    picard
    pigz
    playerctl
    prismlauncher
    pv
    rawtherapee
    ripgrep
    rsync
    rustup
    slurp
    socat
    solaar
    soundconverter
    sqlite
    tealdeer
    telegram-desktop
    tmux
    tofi
    tokei
    tree
    tree-sitter
    udiskie
    unzip
    usbutils
    vesktop
    vim
    wget
    wine
    wine64
    winetricks
    wl-clipboard
    wofi
    zoxide
  ];

  nixpkgs.config.allowUnfree = true;

  # DON'T FUCKING CHANGE THIS
  system.stateVersion = "24.11"; # Did you read the comment?
}
