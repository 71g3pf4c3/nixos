{ config, pkgs, unstable, lib, inputs, ... }: {
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr];
  };
}
