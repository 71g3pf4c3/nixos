{ config, pkgs, unstable, lib, inputs, ... }: {
  imports = [./programs ./services ./xdg.nix ];
}
