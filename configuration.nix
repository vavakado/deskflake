# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, inputs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/bundle.nix
    inputs.spicetify-nix.nixosModules.default
  ];

  nix.package = pkgs.lix;

  # boot.kernelParams = [
  #   "nvidia.NVreg_EnableGpuFirmware=0"
  # ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    avahi
    xcbuild
    libadwaita
    harfbuzz
    libplist
    portaudio
    kdePackages.qtbase
    lzo
    libimobiledevice
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;
  # boot.kernelPackages = pkgs.linuxPackages_6_1;
  boot.tmp.cleanOnBoot = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services.locate = {
    enable = true;
    package = pkgs.plocate;
    interval = "hourly";
  };

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/efi";
    };
    systemd-boot = {
      enable = true;
    };
    # grub = {
    #   efiSupport = true;
    #   device = "nodev";
    # };
  };

  networking.hostName = "uwuw"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Asia/Jerusalem";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.mosh = {
    enable = true;
    withUtempter = true;
  };

  services.ollama = {
    enable = true;
  };

  hardware.uinput.enable = true;
  hardware.logitech.wireless.enableGraphical = true;
  hardware.logitech.wireless.enable = true;
  users.users.vavakado = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "libvirtd"
      "kvm"
      "uinput"
      "dialout"
      "input"
    ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;

  environment.variables = {
    GSETTINGS_SCHEMA_DIR = "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0/schemas";
  };
  programs.dconf.enable = true;
  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };
  environment.systemPackages = with pkgs; [
    # (blender.override {
    #   cudaSupport = true;
    # })
    blender
    (btop.override { cudaSupport = true; })

    xivlauncher

    arduino-ide
    heroic
    # arduino
    adwaita-icon-theme
    anki
    bat
    plocate
    bottles
    chezmoi
    clang
    distrobox
    dust
    dwarfs
    element-desktop
    fastfetch
    fd
    openssl
    ffmpeg
    file-roller
    firefoxpwa
    flite # for narrator
    freetube
    gamescope
    git
    git-extras
    git-lfs
    github-cli
    glow
    playerctl
    gnumake
    go
    grim
    hyprshade
    ifuse
    libimobiledevice
    hyprutils
    imagemagick
    imgbrd-grabber
    jq
    kanata
    kdePackages.qt6ct
    keepassxc
    kitty
    lazydocker
    localsend
    mako
    mangohud
    mold
    mpv
    nemo-fileroller
    rawtherapee
    nemo-with-extensions
    nix-index
    nixfmt-rfc-style
    nodejs
    nvtopPackages.nvidia
    nwg-look
    obs-studio
    onefetch
    p7zip-rar
    pavucontrol
    pigz
    pix
    prismlauncher
    protontricks
    protonup-qt
    pv
    qt6.qtwayland
    revolt-desktop
    ripgrep
    rsync
    rustup
    slurp
    solaar
    soundconverter
    sqlite
    sshfs
    steamtinkerlaunch
    tealdeer
    telegram-desktop
    tmux
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
    xdotool
    vial
    via
    xorg.xprop
    xorg.xrandr
    xorg.xwininfo
    zoxide
  ];

  services.udev.packages = with pkgs; [
    vial
    via
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    nativeMessagingHosts.packages = [ pkgs.firefoxpwa ];
  };

  programs.proxychains = {
    enable = true;
    package = pkgs.proxychains-ng;
    proxies = {
      tor = {
        type = "socks5";
        host = "127.0.0.1";
        port = 9050;
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
    discovery = true;
  };
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.samba = {
    enable = true;
    openFirewall = true;
  };

  services.tor = {
    enable = true;
    # Enable Torsocks for transparent proxying of applications through Tor
    torsocks = {
      enable = true;
      allowInbound = true;
    };
    client = {
      enable = true;
      dns.enable = true;
    };
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
    };
  };

  fonts.packages =
    with pkgs;
    [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      fira-code
      fira-sans
      roboto
      fira-code-symbols
      corefonts
    ]
    ++ (builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts)); # super weird nix fuckery

  programs.steam.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d";
    flake = "/home/vavakado/Config/deskflake/";
  };

  nixpkgs.config.allowUnfree = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 61208 ];
  # networking.firewall.allowedUDPPorts = [ 61208 ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # DON'T FUCKING CHANGE THIS
  system.stateVersion = "24.11"; # Did you read the comment?

}
