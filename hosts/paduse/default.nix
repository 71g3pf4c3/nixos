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
    ./configuration.nix
    ./sway.nix
    ./hardware-configuration.nix
  ];
}
