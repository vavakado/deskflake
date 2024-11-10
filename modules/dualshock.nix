{
  ...
}:
{
  services.udev.extraRules = ''
    SUBSYSTEM=="input", ATTRS{name}=="*Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';
}
