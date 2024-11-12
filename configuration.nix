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

  boot.kernelPackages = pkgs.linuxPackages_zen;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/efi";
    };
    grub = {
      efiSupport = true;
      device = "nodev";
    };
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
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
      "input"
    ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [

    # (blender.override { cudaSupport = true; }) # TODO: wait for https://nixpk.gs/pr-tracker.html?pr=354095 to be merged into unstable
    (btop.override { cudaSupport = true; })
    adwaita-icon-theme
    anki
    bat
    bottles
    calibre
    chezmoi
    clang
    dust
    dwarfs
    element-desktop
    fastfetch
    fd
    ffmpeg
    file-roller
    firefoxpwa
    flite # for narrator
    freetube
    gamescope
    gimp
    git
    git-extras
    git-lfs
    github-cli
    glow
    gnumake
    go
    godot_4
    grim
    hyprshade
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
    mako
    mangohud
    mold
    mpv
    nemo-fileroller
    nemo-with-extensions
    neovide
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
    waybar
    wget
    wine
    wine64
    winetricks
    wl-clipboard
    wofi
    xdotool
    xorg.xprop
    xorg.xrandr
    xorg.xwininfo
    zoxide
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

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    nerdfonts
    fira-code
    fira-sans
    roboto
    fira-code-symbols
  ];

  programs.steam.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d";
    flake = "/home/vavakado/deskflake/";
  };

  nixpkgs.config.allowUnfree = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 61208 ];
  networking.firewall.allowedUDPPorts = [ 61208 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # DON'T FUCKING CHANGE THIS
  system.stateVersion = "24.11"; # Did you read the comment?

}
