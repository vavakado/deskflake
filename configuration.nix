# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/bundle.nix
    inputs.spicetify-nix.nixosModules.default
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  hardware.uinput.enable = true;
  hardware.logitech.wireless.enableGraphical = true;
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
    packages = [ ];
  };

  environment.systemPackages = with pkgs; [
    (blender.override { cudaSupport = true; })
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
    eza
    fastfetch
    fd
    feh
    ffmpeg
    file-roller
    flite # for narrator
    foot
    freetube
    fzf
    gamescope
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
    imv
    jellyfin-mpv-shim
    jq
    kdePackages.qt6ct
    keepassxc
    lazydocker
    localsend
    loupe
    mako
    mako
    mangohud
    mold
    mpv
    mpv-shim-default-shaders
    nemo-fileroller
    nemo-with-extensions
    neovide
    neovim
    nixfmt
    nodejs
    nvtopPackages.nvidia
    nwg-look
    obs-studio
    onefetch
    p7zip-rar
    pavucontrol
    pigz
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
    starship
    steamtinkerlaunch
    surrealdb
    surrealist
    swaybg
    tealdeer
    teamspeak5_client
    telegram-desktop
    thunderbird
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
    yad
    zig
    zoxide
  ];

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

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    nerdfonts
    fira-code
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
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # DON'T FUCKING CHANGE THIS
  system.stateVersion = "24.11"; # Did you read the comment?

}

