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
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  # programs.wayfire = {
  #   enable = true;
  #   plugins = with pkgs.wayfirePlugins; [
  #     wcm
  #     wf-shell
  #     wayfire-plugins-extra
  #   ];
  # };

  # services.xserver = {
  #   enable = true;
  #   displayManager.gdm.enable = true;
  #   desktopManager.gnome.enable = true;
  # };
  #
  # environment.systemPackages = with pkgs; [
  #   gnome.gnome-tweaks
  #   gnomeExtensions.appindicator
  #   gnomeExtensions.dash-to-dock
  #   gnomeExtensions.blur-my-shell
  #   gnomeExtensions.search-light
  # ];
  #
  # services.udev.packages = [ pkgs.gnome.gnome-settings-daemon ];
}
