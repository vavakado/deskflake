{ pkgs, ... }:
{
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  environment.systemPackages = [ pkgs.blueberry ];
}
