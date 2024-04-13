{ config, pkgs, unstable, lib, inputs, ... }: {
  imports = [
    ./mako.nix
    ./swayidle.nix
    ./base.nix
  ];
}
