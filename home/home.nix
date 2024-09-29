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
  programs.home-manager.enable = true;
}
