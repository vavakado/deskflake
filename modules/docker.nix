{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.docker-compose
    pkgs.docker-buildx
  ];

  hardware.nvidia-container-toolkit.enable = true;
  virtualisation.docker = {
    enable = true;
    liveRestore = false;
    enableOnBoot = true;
  };
}
