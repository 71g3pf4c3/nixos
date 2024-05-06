{ pkgs, lib, ... }:
{
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [
  #     pkgs.xdg-desktop-portal-gtk
  #     pkgs.xdg-desktop-portal-hyprland
  #   ];
  #   # config.common = {
  #   #   default = "hyprland;gtk";
  #   #   "freedesktop.impl.portal.Screenshot" = "wlr";
  #   #   "freedesktop.impl.portal.ScreenCast" = "wlr";
  #   # };
  #   wlr = {
  #     enable = true;
  #     settings = {
  #       screencast = {
  #         max_fps = 30;
  #         chooser_type = "simple";
  #         chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
  #       };
  #     };
  #   };
  # };
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
}
