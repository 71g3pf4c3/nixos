{
  config,
  pkgs,
  unstable,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./rofi.nix
    ./sway.nix
    ./swaylock.nix
    ./waybar
    ./mpv.nix
    ./wpaperd.nix
  ];
}
