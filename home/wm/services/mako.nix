{ config, pkgs, unstable, lib, inputs, ... }: {
  services.mako = {
      enable = true;
      anchor = "bottom-center";
      defaultTimeout = 5000;
      ignoreTimeout = true;
      backgroundColor = "#${config.colorScheme.palette.darkbg}";
      borderColor = "#${config.colorScheme.palette.darkgreen}";
      textColor = "#${config.colorScheme.palette.darkfg}";
      borderSize = 2;
      borderRadius = 5;
    };
}
