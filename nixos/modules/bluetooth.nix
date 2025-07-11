{ pkgs, ... }:
{
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  services.blueman.enable = true;
  environment.systemPackages = [ pkgs.blueberry ];
}
