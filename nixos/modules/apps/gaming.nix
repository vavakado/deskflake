{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    extraPackages = with pkgs; [
      gamescope
      mangohud
    ];
    protontricks.enable = true;
  };

  # disable touchpad of dualshock controllers
  services.udev.extraRules = ''
    SUBSYSTEM=="input", ATTRS{name}=="*Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';
}
