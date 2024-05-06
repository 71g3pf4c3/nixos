{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    rocketchat-desktop
    telegram-desktop
  ];
}
