{ config, pkgs, unstable, lib, inputs, ... }: 
let
  font = "Comic Code Ligatures";
in
{
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "${font}:size=9";
        dpi-aware = "no";
        shell = "${lib.getExe pkgs.zsh}";
      };
      mouse = {
        hide-when-typing = "yes";
      };
      colors = {
        alpha = 0.95;
        background = "${config.colorScheme.palette.base00}";
        foreground = "${config.colorScheme.palette.base07}";
        regular0 = "${config.colorScheme.palette.base00}";
        regular1 = "${config.colorScheme.palette.base08}";
        regular2 = "${config.colorScheme.palette.base0B}";
        regular3 = "${config.colorScheme.palette.base0A}";
        regular4 = "${config.colorScheme.palette.base0D}";
        regular5 = "${config.colorScheme.palette.base0E}";
        regular6 = "${config.colorScheme.palette.base0C}";
        regular7 = "${config.colorScheme.palette.base07}";
        bright0 = "${config.colorScheme.palette.base01}";
        bright1 = "${config.colorScheme.palette.base08}";
        bright2 = "${config.colorScheme.palette.base0B}";
        bright3 = "${config.colorScheme.palette.base0A}";
        bright4 = "${config.colorScheme.palette.base0D}";
        bright5 = "${config.colorScheme.palette.base0E}";
        bright6 = "${config.colorScheme.palette.base0C}";
        bright7 = "${config.colorScheme.palette.base03}";
      };
    };
  };
}
