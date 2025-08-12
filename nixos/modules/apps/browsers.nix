{
  inputs,
  system,
  ...
}:
{
  environment.systemPackages = [
    inputs.zen-browser.packages."${system}".default
  ];

  programs.firefox = {
    enable = true;
    package = inputs.firefox.packages.${system}.firefox-nightly-bin;
  };
}
