{ pkgs, ... }:
{
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
  environment.systemPackages = with pkgs; [
    udiskie
  ];
}
