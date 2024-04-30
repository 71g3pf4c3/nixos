{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  home.username = "t1g3pf4c3";
  home.homeDirectory = "/home/t1g3pf4c3";
  home.stateVersion = "23.11";
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
    size = 22;
  };
  programs.home-manager.enable = true;
}
