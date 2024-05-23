{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-hyprland
    ];
    config.common = {
      default = "hyprland;gtk";
      # "freedesktop.impl.portal.Screenshot" = "wlr";
      # "freedesktop.impl.portal.ScreenCast" = "wlr";
      "org.freedesktop.impl.portal.FileChooser"="gtk";

    };
  };
}
