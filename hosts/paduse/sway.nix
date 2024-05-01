{ pkgs, lib, ... }:
{
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    wlr = {
      enable = true;
      settings = {
        screencast = {
          max_fps = 30;
          chooser_type = "simple";
          chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
        };
      };
    };
  };
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
}
