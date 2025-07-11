{ pkgs, ... }:
{
  services.locate = {
    enable = true;
    package = pkgs.plocate;
    interval = "hourly";
  };
  environment.systemPackages = with pkgs; [ plocate ];
}
