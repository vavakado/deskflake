{
  inputs,
  system,
  ...
}:
{
  environment.systemPackages = [
    inputs.menucalc.packages.${system}.menucalc
  ];
}
