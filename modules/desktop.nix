{
  pkgs,
  ...
}:
{
  services.xserver = {
    xkb.extraLayouts.colemak-caps = {
      description = "Colemak layout wiht no caps remap";
      languages = [ "eng" ];
      symbolsFile = ../us;
    };
  };

  systemd = {
    user.services.hyprpolkitagent = {
      description = "hyprpolkitagent";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  programs.hyprland.enable = true;
  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;
  # TODO: wait for pr https://nixpk.gs/pr-tracker.html?pr=353338

  services.displayManager.ly.enable = true;
}
