{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.docker-compose ];

  hardware.nvidia-container-toolkit.enable = true;
  virtualisation.docker = {
    enable = true;
    liveRestore = false;
    enableNvidia = true;
  };
}
