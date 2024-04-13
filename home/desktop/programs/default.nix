{ config, pkgs, unstable, lib, inputs, ... }: {
  imports = [
    ./foot.nix
    ./zathura.nix
    ./chromium.nix
  ];
}
