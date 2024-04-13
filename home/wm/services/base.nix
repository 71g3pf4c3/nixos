{ config, pkgs, unstable, lib, inputs, ... }: {
  services = {
    udiskie = {
      enable = true;
    };
    kdeconnect = {
      enable = true;
      indicator = true;
    };
    network-manager-applet.enable = true;
    cliphist = {
      enable = true;
      systemdTarget = "sway-session.target";
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
