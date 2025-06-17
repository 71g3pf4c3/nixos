{
  config,
  pkgs,
  unstable,
  lib,
  inputs,
  ...
}:
{
  services = {
    udiskie = {
      enable = true;
    };
    kdeconnect = {
      enable = false;
      indicator = true;
    };
    # network-manager-applet.enable = true;
    cliphist = {
      enable = true;
      systemdTargets = ["sway-session.target"];
    };
    gammastep = {
      enable = true;
      latitude = "56.7";
      longitude = "37.1";
      tray = true;
    };
    # blueman-applet.enable = true;
  };

  systemd.user.services.blueman-applet = {
    Unit = {
      Description = "Blueman applet";
      PartOf = [ "sway-session.target" ];
      After = ["tray.target" "sway-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.blueman}/bin/blueman-applet";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "sway-session.target" ];
  };
  systemd.user.services.nm-applet = {
    Unit = {
      Description = "NetworkManager applet";
      PartOf = [ "sway-session.target" ];
      After = ["tray.target" "sway-session.target"];
    };
    Service = {
      ExecStart = "${lib.getExe pkgs.networkmanagerapplet}";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "sway-session.target" ];
  };
  # systemd.user.services.otd-user-daemon = {
  #   Unit = {
  #     Description = "OTD daemon";
  #     PartOf = [ "sway-session.target" ];
  #     After = ["tray.target" "sway-session.target"];
  #   };
  #   Service = {
  #     ExecStart = "${pkgs.opentabletdriver}/bin/otd-daemon";
  #     Restart = "on-failure";
  #   };
  #   Install.WantedBy = [ "sway-session.target" ];
  # };
}
