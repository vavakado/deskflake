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

  nix = {
    package = pkgs.lix;
    settings = {
      substituters = [
        "https://cache.nixos.org/"
        # "https://cache.garnix.io"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        # "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
      trusted-users = [
        "root"
        "@wheel"
        "vavakado"
      ];
      secret-key-files = [
        "/home/vavakado/Documents/sign/cache-priv-key.pem"
      ];
    };
  };

  boot.supportedFilesystems = [ "ntfs" ];
  # fileSystems."/mnt/corpse" = {
  #   device = "/dev/disk/by-uuid/01D9C60AB3801AB0";
  #   fsType = "nfts-3g";
  #   options = [
  #     "uid=1000"
  #     "gid=100"
  #     "dmask=027"
  #     "fmask=137"
  #     "rw"
  #   ];
  # };

  fileSystems."/mnt/vault156" = {
    device = "/dev/disk/by-uuid/a607cf11-85e9-4d2a-b9b0-ccc1fa23e9a5";
    fsType = "ext4";
    options = [ "x-systemd.automount" ];
  };

  hardware.i2c.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    avahi
    xcbuild
    icu
    libadwaita

    xorg.libX11
    libjack2
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi
    xorg.libxcb
    libxkbcommon
    libGL
    harfbuzz
    libplist
    portaudio
    kdePackages.qtbase
    lzo

    nss
    libimobiledevice
  ];

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    lfs.enable = true;
    config = {
      init = {
        defaultBranch = "main";
      };
      url = {
        "https://github.com/" = {
          insteadOf = [
            "gh:"
            "github:"
          ];
        };
      };
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;
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
  services.flatpak.enable = true;

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/efi";
    };
    systemd-boot = {
      enable = true;
    };
  };

  programs.obs-studio = {
    enable = false;
    plugins = with pkgs.obs-studio-plugins; [
      obs-backgroundremoval
    ];
  };

  networking.hostName = "uwuw"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Asia/Jerusalem";

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
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
      "i2c"
      "libvirtd"
      "kvm"
      "uinput"
      "dialout"
      "input"
    ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;

  environment.variables = {
    GSETTINGS_SCHEMA_DIR = "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0/schemas";
  };

  programs.niri.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    (blender.override {
      cudaSupport = true;
      openUsdSupport = false;
    })
    (btop.override { cudaSupport = true; })

    waybar
    fuzzel
    alacritty
    xwayland-satellite
    # xorg.xprop
    # xorg.xrandr
    # xorg.xwininfo
    adwaita-icon-theme
    anki
    bat
    chezmoi
    clang
    ddcutil
    dust
    dwarfs
    element-desktop
    fastfetch
    fd
    ffmpeg-full
    ab-av1
    file-roller
    flite # for narrator
    freetube
    git-extras
    github-cli
    glow
    gnumake
    go
    grim
    imagemagick
    jellyfin-mpv-shim
    jq
    kdePackages.qt6ct
    keepassxc
    kitty
    localsend
    mako
    mangohud
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
    # pix
    playerctl
    plocate
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
    sshfs
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
    vial
    vim
    wget
    wine
    wine64
    winetricks
    wl-clipboard
    wofi
    zoxide

    godot-mono
  ];

  services.udev.packages = with pkgs; [
    vial
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
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

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-mozc
        # fcitx5-gtk
      ];
      quickPhrase = {
        smile = "（・∀・）";
        angry = "(￣ー￣)";
        sad = "(︶︹︺)";
        surprised = "（゜◇゜）";
        smug = "(¬‿¬)";
        cry = "(Ｔ▽Ｔ)";
        confused = "(・_・ヾ";
        blush = "(⁄ ⁄>⁄ ▽ ⁄<⁄ ⁄)";
        evil = "Ψ(｀▽´)Ψ";
        lenny = "( ͡° ͜ʖ ͡°)";
        shrug = "¯\\_(ツ)_/¯";
        tableflip = "(╯°□°）╯︵ ┻━┻";
        unflip = "┬─┬ ノ( ゜-゜ノ)";
        scream = "ヽ(ﾟДﾟ)ﾉ";
        thinking = "(☞ﾟヮﾟ)☞";
        suspicious = "눈_눈";
        dead = "x_x";
        happyCry = "(；▽；)";
        no = "（；¬＿¬）";
        yes = "٩(◕‿◕｡)۶";
        facepalm = "(－‸ლ)";
        tired = "(-_-)zzz";
        bored = "(๑-﹏-)";
        panic = "(;慌;)";
        derp = ">_>;";
        love = "(♥‿♥)";
        idea = "(⌐■_■)";
        cool = "(*^▽^*)";
        flustered = "( ◡▽◡)";
        sneaky = "(_)...";
        sleepy = "(。-`ω´-)";
        hungry = "＼(ºωº`)／";
        yawn = "(＾-゜)";
        party = "ヽ(•̀ᴗ•́)ノ";
        derp2 = "O_O";
        shock = "Σ( ° △ °|||)";
        rage = ">:(((((";
        grin = "^_^";
        smirk = "¬_¬";
        sigh = "(¬_¬)";
        drool = "\\(¦3:)\\/\"";
        flex = "(ง •_•)ง";
        jazzhands = "(◕‿◕✿)";
        meh = "¯\\_(ツ)_/¯";
        success = "ε(´∀`)ε";
        victory = "＼(＾○＾)／";
        failure = "(x_x)";
        oops = "(」o‸o)」";
        sorry = "(T_T)";
        blame = "('_')";
        helpless = "(„ᵕᴗᵕ„)";
        brokenheart = "(╥﹏╥)";
        starve = "(つω`*)";
        chill = "8-)";
        curious = "( ・ω・)";
        nerd = "8-|";
        sarcastic = "┐(￣ヘ￣)┌";
        sweatdrop = "(汗)";
        sparkles = "(ﾉ◕ヮ◕)ﾉ*:･ﾟ✧";

        awkward = "(・_・;)";
        prayer = "(*・人・*)";
        plotting = "(¬‿¬ )";
        fakeSmile = "(＾▽＾)";
        geek = "(☞ﾟ∀ﾟ)☞";
        mindBlown = "(°ロ°)☝";
        pokerFace = "(・_・)";
        tearsOfJoy = "｡ﾟ( ﾟ^∀^ﾟ)ﾟ｡";
        sobbing = "(இ﹏இ`｡)";
        gremlin = "ʕ•ᴥ•ʔ";
        baka = "(≧д≦ヾ)";
        sneezed = "(｡•́︿•̀｡)";
        zoomer = "(☞ﾟヮﾟ)☞ YEET";
        edgy = "☠(▀̿Ĺ̯▀̿ ̿)";
        glitch = "⸮‽⸘⸮‽";
        hacker = "(▀̿Ĺ̯▀̿ ̿)";
        nihilist = "(╯︵╰,)";
        woozy = "(◎_◎;)";
        dramatic = "∑(O_O;)";
        monkaS = "(；ﾟДﾟ)";
        ew = "(＃＞＜)";
        wheeze = "(≧▽≦)ノ";
        rageQuit = "༼ つ ◕_◕ ༽つ ┻━┻";
        spooky = "༼ つ ▀_▀ ༽つ";
        goblin = "(ﾉಥ益ಥ）ﾉ﻿ ┻━┻";
      };
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
