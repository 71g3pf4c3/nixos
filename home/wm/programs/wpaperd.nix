{ config, pkgs, unstable, lib, inputs, ... }: {
  programs.wpaperd = {
    enable = true;
    settings = {
      default = {
        path = "${config.home.homeDirectory}/etc/wallpapers/struct3_sepia_nix.png "; 
      };
    };
  };
}
