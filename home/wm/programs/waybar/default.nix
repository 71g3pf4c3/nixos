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
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "sway-session.target";
    style = lib.concatStrings [
      ''
        * {
        		font-family: ${font};
        		font-size: 13px;
        }
      ''
      (builtins.readFile (
        pkgs.substituteAll {
          src = ./style.css;
          bg = "#${config.colorScheme.palette.darkbg}";
          fg = "#${config.colorScheme.palette.darkfg}";
          green = "#${config.colorScheme.palette.darkgreenalt}";
          red = "#${config.colorScheme.palette.darkredalt}";
          yellow = "#${config.colorScheme.palette.darkyellowalt}";
          gray = "#${config.colorScheme.palette.darkgray}";
        }
      ))
    ];
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-rignt = 0;
        modules-left = [
          "wlr/workspaces"
          "sway/workspaces"
          "sway/mode"
          "custom/media"
        ];
        modules-center = [ "sway/window" ];
        modules-right = [
          "idle_inhibitor"
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "keyboard-state"
          "sway/language"
          "battery"
          "clock"
          "tray"
        ];
        "sway/window" = { };
        "sway/language" = { };
        "sway/workspaces" = {
          "format" = "{icon}";
          "format-icons" = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            # "focused" = "";
            "default" = "";
          };
        };
        "wlr/workspaces" = {
          "format" = "{icon}";
          "format-icons" = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "focused" = "";
            "default" = "";
          };
          "on-scroll-up" = "hyprctl dispatch workspace e+1";
          "on-scroll-down" = "hyprctl dispatch workspace e-1";
        };
        "idle_inhibitor" = {
          "format" = "{icon}";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
        };
        "clock" = {
          "format" = "{:%H:%M %d.%m }";
        };
        "tray" = { };
        "sway/mode" = {
          "format" = ''<span style="italic">{}</span>'';
        };
        "cpu" = {
          "format" = "{usage}% ";
          "tooltip" = false;
        };
        "memory" = {
          "format" = "{}% ";
        };
        "battery" = {
          "states" = {
            "good" = 95;
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{capacity}% {icon}";
          "format-charging" = "{capacity}% ";
          "format-plugged" = "{capacity}% ";
          "format-alt" = "{time} {icon}";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        "pulseaudio" = {
          "scroll-step" = 1;
          "format" = "{volume}% {icon} {format_source}";
          "format-bluetooth" = "{volume}% {icon}  {format_source}";
          "format-bluetooth-muted" = "🔇 {icon}  {format_source}";
          "format-muted" = "🔇 {format_source}";
          "format-source" = "{volume}% ";
          "format-source-muted" = "";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [
              ""
              ""
              ""
            ];
          };
        };
        "network" = {
          "format-wifi" = "({signalStrength}%) ";
          "format-ethernet" = "{ipaddr}/{cidr} ";
          "tooltip-format" = "{ifname} via {gwaddr} ";
          "format-linked" = "{ifname} (No IP) ";
          "format-disconnected" = "Disconnected ⚠";
          "format-alt" = "{ifname}: {ipaddr}/{cidr}";
        };
      };
    };
  };
}
