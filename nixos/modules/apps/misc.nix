{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    chezmoi # dotfile manager
    # TODO: move to home-manager
    (blender.override {
      openUsdSupport = false;
    })
    #messangers
    vesktop
    element-desktop
    telegram-desktop
    #dev
    clang
    gnumake
    go
    godot-mono
    jq
    tree-sitter
    rustup
    mold
    nixfmt-rfc-style
    nodejs
    socat
    onefetch
    vim
    tokei
    #utils
    ab-av1
    bat
    rsync
    tree
    btop
    dust
    dwarfs
    fastfetch
    fd
    ffmpeg-full
    tmux
    tealdeer
    sqlite
    imagemagick
    nix-index
    nvtopPackages.nvidia
    p7zip-rar
    pigz
    unzip
    pv
    ripgrep
    usbutils
    wget
    zoxide
    # just apaps
    anki
    jellyfin-mpv-shim
    localsend
    mpv
    mpv-shim-default-shaders
    picard
    rawtherapee
    soundconverter
    keepassxc
    newsflash
    #apps for desktop
    file-roller
    nemo-fileroller
    nemo-with-extensions
    nwg-look
    pavucontrol
    playerctl
  ];
}
