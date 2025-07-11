{
  inputs,
  pkgs,
  system,
  ...
}:
{
  environment.systemPackages = [ inputs.zen-browser.packages."${system}".default ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
  };
}
