{
  config,
  stdenv,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  home.username = "t1g3pf4c3";
  home.homeDirectory = "/home/t1g3pf4c3";
  home.stateVersion = "23.11";
  home.file."${config.home.homeDirectory}/.local/share/fonts" = {
    source = ./appearance/fonts;
    recursive = true;
  };
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
    size = 22;
  };
  programs.home-manager.enable = true;
}
