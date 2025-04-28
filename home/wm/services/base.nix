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
    network-manager-applet.enable = true;
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
    blueman-applet.enable = true;
  };
}
