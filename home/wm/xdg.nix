{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
    ];
    config.common = {
      default = "wlr;gtk";
      "freedesktop.impl.portal.Screenshot" = "wlr";
      "freedesktop.impl.portal.ScreenCast" = "wlr";
      "org.freedesktop.impl.portal.FileChooser" = "gtk";
    };
  };
}
