{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.docker-compose
    pkgs.docker-buildx
  ];

  virtualisation.docker = {
    enable = true;
    liveRestore = false;
    enableOnBoot = true;
  };
}
