{ config, pkgs, unstable, lib, inputs, ... }: {
  services.mako = {
      enable = true;
      anchor = "bottom-center";
      defaultTimeout = 5000;
      ignoreTimeout = true;
      backgroundColor = "#${config.colorScheme.palette.base00}";
      borderColor = "#${config.colorScheme.palette.base0B}";
      textColor = "#${config.colorScheme.palette.base07}";
      borderSize = 2;
      borderRadius = 5;
    };
}
