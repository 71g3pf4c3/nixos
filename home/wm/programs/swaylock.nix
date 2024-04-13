{ config, pkgs, unstable, lib, inputs, ... }: {
  programs.swaylock = {
    enable = true;
    settings = {
      color = config.colorScheme.palette.base07;
    };
  };
}
