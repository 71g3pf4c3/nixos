{
  config,
  pkgs,
  unstable,
  lib,
  inputs,
  ...
}:
{
  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };
  home.packages = with pkgs; [
    ncdu
    telegram-desktop
    nh
    nvd
    tree-sitter
    nodePackages.webtorrent-cli
    qbittorrent
    libreoffice
    drawio
    wineWowPackages.waylandFull
    bottles
    webtorrent_desktop
  ];
}
