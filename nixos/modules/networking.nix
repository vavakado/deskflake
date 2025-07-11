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
    openFirewall = true;
  };

  services.zerotierone.enable = true;
  networking.networkmanager.enable = true;
  networking.nameservers = [
    "9.9.9.9"
    "149.112.112.112"
  ];
  services.dnsmasq.settings = {
    port = 5353; # Change dnsmasq to use port 5353
  };
  services.resolved.extraConfig = "DNSStubListener=no";
  services.openssh.enable = true;
}
