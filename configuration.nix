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
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable =
    true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Jerusalem";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  #services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  #OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vavakado = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = [ ];
  };

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
      colorScheme = "base";
    };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # lazydocker
    (blender.override { cudaSupport = true; })
    (btop.override { cudaSupport = true; })
    anki
    adwaita-icon-theme
    bat
    calibre
    nemo-with-extensions
    dust
    dwarfs
    element-desktop
    eza
    fastfetch
    fd
    feh
    ffmpeg
    file-roller
    foot
    fzf
    gamescope
    git
    chezmoi
    flite
    vesktop
    qt6.qtwayland
    git-extras
    freetube
    github-cli
    glow
    go
    godot_4
    hyprshade
    hyprutils
    imgbrd-grabber
    imv
    jellyfin-mpv-shim
    jq
    localsend
    loupe
    mako
    mako
    mangohud
    mold
    mpv
    mpv-shim-default-shaders
    nemo-fileroller
    neovide
    neovim
    nixfmt
    nodejs
    nvtopPackages.nvidia
    obs-studio
    onefetch
    p7zip-rar
    pavucontrol
    kdePackages.qt6ct
    pigz
    prismlauncher
    pv
    ripgrep
    rsync
    rustup
    slurp
    grim
    solaar
    soundconverter
    sqlite
    sshfs
    starship
    surrealdb
    surrealist
    swaybg
    tealdeer
    telegram-desktop
    thunderbird
    tmux
    tokei
    tree
    tree-sitter
    udiskie
    vim
    waybar
    wget
    wl-clipboard
    wofi
    zig
    keepassxc
    zoxide
    nixd
    clang
    nwg-look
  ];

  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.samba.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    nerdfonts
    fira-code
    fira-code-symbols
  ];

  hardware.graphics = { enable = true; };

  services.xserver = {
    xkb.extraLayouts.colemak-caps = {
      description = "Colemak layout wiht no caps remap";
      languages = [ "eng" ];
      symbolsFile = ./us;
    };
  };

  services.avahi = {
    enable = true;
    ipv6 = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      domain = true;
      userServices = true;
      workstation = true;
    };
  };

  services.zerotierone = { enable = true; };

  programs.hyprland.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  programs.steam.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d";
    flake = "/home/vavakado/deskflake/";
  };

  hardware.graphics.enable32Bit = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
  nixpkgs.config.allowUnfree = true;

  systemd = {
    #    user.services.polkit-kde-authentication-agent-1 = {
    #      description = "polkit-kde-authentication-agent-1";
    #      wantedBy = [ "graphical-session.target" ];
    #      wants = [ "graphical-session.target" ];
    #      after = [ "graphical-session.target" ];
    #      serviceConfig = {
    #        Type = "simple";
    #        ExecStart =
    #          "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
    #        Restart = "on-failure";
    #        RestartSec = 1;
    #        TimeoutStopSec = 10;
    #      };
    #    };
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

