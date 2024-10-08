{ pkgs, ... }: {
  services.sunshine = {
    enable = true;
    openFirewall = true;
    capSysAdmin = true;
    package = (pkgs.sunshine.override { cudaSupport = true; });
  };
}
