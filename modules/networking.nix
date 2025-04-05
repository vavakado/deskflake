{
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

  services.zerotierone.enable = true;
  networking.networkmanager.enable = false;
  services.openssh.enable = true;
  services.resolved = {
    enable = true;
  };
  networking.useDHCP = true;
  networking.dhcpcd.enable = true;
}
