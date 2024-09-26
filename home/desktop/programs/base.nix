{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    pavucontrol
    xdragon
    sxiv
    wdisplays
    wl-clipboard
  ];
}
