{
  config,
  pkgs,
  unstable,
  lib,
  inputs,
  ...
}:
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
      key-bindings = {
        show-urls-launch = "Control+o";
      };
      colors = {
        alpha = 0.95;
        background = "${config.colorScheme.palette.lightbg}";
        foreground = "${config.colorScheme.palette.lightfg}";
        regular0 = "${config.colorScheme.palette.lightbg}";
        regular1 = "${config.colorScheme.palette.lightred}";
        regular2 = "${config.colorScheme.palette.lightgreen}";
        regular3 = "${config.colorScheme.palette.lightyellow}";
        regular4 = "${config.colorScheme.palette.lightblue}";
        regular5 = "${config.colorScheme.palette.lightpurple}";
        regular6 = "${config.colorScheme.palette.lightaqua}";
        regular7 = "${config.colorScheme.palette.lightfg}";
        bright0 = "${config.colorScheme.palette.lightbg2}";
        bright1 = "${config.colorScheme.palette.lightredalt}";
        bright2 = "${config.colorScheme.palette.lightgreenalt}";
        bright3 = "${config.colorScheme.palette.lightyellowalt}";
        bright4 = "${config.colorScheme.palette.lightbluealt}";
        bright5 = "${config.colorScheme.palette.lightpurplealt}";
        bright6 = "${config.colorScheme.palette.lightaquaalt}";
        bright7 = "${config.colorScheme.palette.lightbg4}";
      };
    };
  };
}
