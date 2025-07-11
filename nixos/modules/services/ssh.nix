{ pkgs, ... }:
{
  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [ sshfs ];
}
