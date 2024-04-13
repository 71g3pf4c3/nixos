{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    inputs.nix-colors.homeManagerModules.default
    ./terminal
    ./desktop
    ./wm
    ./home.nix
    ./xdg.nix
  ];
  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-light-medium;
}
