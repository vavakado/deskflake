{ pkgs, ... }:
{
  users.users.vavakado = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "i2c"
      "libvirtd"
      "kvm"
      "uinput"
      "dialout"
      "input"
    ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
}
