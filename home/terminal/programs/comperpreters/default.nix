{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    cargo
    nodejs
    python3
    go
  ];
}
