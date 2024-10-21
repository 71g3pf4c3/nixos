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
    sxiv
    wdisplays
    wl-clipboard
    qbittorrent
  ];
}
