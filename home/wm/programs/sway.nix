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
  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
    '';
    wrapperFeatures = {
      gtk = true;
      base = true;
    };
    xwayland = true;
    extraConfig = ''
      titlebar_border_thickness 0
      titlebar_padding 20 0
      for_window [app_id="waydroid.*"] floating enable
    '';
    config = {
      startup = [
        {
          command = "systemctl --user restart blueman-applet";
          always = true;
        }
        {
          command = "systemctl --user restart swayidle";
          always = true;
        }
        {
          command = "systemctl --user restart waybar";
          always = true;
        }
        {
          command = "systemctl --user restart network-manager-applet";
          always = true;
        }
        {
          command = "systemctl --user restart swaybg";
          always = true;
        }
      ];
      window = {
        hideEdgeBorders = "smart";
        border = 3;
        titlebar = true;
      };
      workspaceLayout = "tabbed";
      workspaceAutoBackAndForth = true;
      colors = {
        background = config.colorScheme.palette.lightbg1;
        focused = {
          background = config.colorScheme.palette.lightbg;
          border = config.colorScheme.palette.lightgreen;
          childBorder = config.colorScheme.palette.lightgreenalt;
          text = config.colorScheme.palette.lightfg;
          indicator = config.colorScheme.palette.lightaqua;
        };
        focusedInactive = {
          background = config.colorScheme.palette.lightbg3;
          border = config.colorScheme.palette.lightbg3;
          childBorder = config.colorScheme.palette.lightbg3;
          text = config.colorScheme.palette.lightfg;
          indicator = config.colorScheme.palette.lightaqua;
        };
        unfocused = {
          background = config.colorScheme.palette.lightbg3;
          border = config.colorScheme.palette.lightbg1;
          childBorder = config.colorScheme.palette.lightbg1;
          text = config.colorScheme.palette.lightfg;
          indicator = config.colorScheme.palette.lightaqua;
        };
      };
      fonts = {
        names = [ font ];
        style = "Regular";
        size = 9.0;
      };
      gaps = {
        top = 1;
        bottom = 1;
        horizontal = 2;
        vertical = 2;
        inner = 2;
        outer = 2;
        left = 2;
        right = 2;
        smartBorders = "on";
        smartGaps = true;
      };
      modifier = "Mod4";
      terminal = "${lib.getExe pkgs.foot} -- tmux new -A";
      menu = "${lib.getExe pkgs.rofi-wayland} -show drun";
      bars = [ ];
      bindkeysToCode = true;
      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "XF86MonBrightnessUp" = "exec ${lib.getExe pkgs.brightnessctl} set 5%+";
          "XF86MonBrightnessDown" = "exec ${lib.getExe pkgs.brightnessctl} set 5%-";
          "XF86AudioRaiseVolume" = "exec ${lib.getExe pkgs.pamixer} --allow-boost -i 5";
          "XF86AudioLowerVolume" = "exec ${lib.getExe pkgs.pamixer} --allow-boost -d 5";
          "XF86AudioMute" = "exec ${lib.getExe pkgs.pamixer} --toggle-mute";
          "XF86AudioMicMute" = "exec ${lib.getExe pkgs.pamixer} --default-source -t t";
          "${modifier}+t" = "exec ${lib.getExe pkgs.sway-overfocus} group-rw group-dw";
          "${modifier}+h" = "exec ${lib.getExe pkgs.sway-overfocus} split-lt float-lt output-ls";
          "${modifier}+k" = "exec ${lib.getExe pkgs.sway-overfocus} split-ut float-ut output-us";
          "${modifier}+j" = "exec ${lib.getExe pkgs.sway-overfocus} split-dt float-dt output-ds";
          "${modifier}+l" = "exec ${lib.getExe pkgs.sway-overfocus} split-rt float-rt output-rs";
          "${modifier}+Shift+t" = "exec ${lib.getExe pkgs.sway-overfocus} group-lw group-uw";
          "${modifier}+w" = "kill";
          "${modifier}+Shift+r" = "reload";
          "${modifier}+Control+h" = "resize shrink width 4";
          "${modifier}+Control+l" = "resize grow width 4";
          "${modifier}+Control+j" = "resize shrink height 4";
          "${modifier}+Control+k" = "resize grow height 4";
          "${modifier}+Shift+q" = "exit";
          "${modifier}+s" = "layout stacking";
          "${modifier}+x" = "layout tabbed";
          "${modifier}+f" = "fullscreen";
          "${modifier}+Shift+f" = "floating toggle";
          "${modifier}+Shift+v" = "exec ${lib.getExe pkgs.rofi-pass-wayland}";
          "${modifier}+n" = "focus mode_toggle";
          "${modifier}+p" = "exec ${lib.getExe pkgs.rofi-wayland} -show drun";
          "${modifier}+Tab" = "exec ${lib.getExe pkgs.rofi-wayland} -show window";
          "${modifier}+v" =
            "exec ${lib.getExe pkgs.cliphist} list | rofi -dmenu | cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy ";
          "Print" = ''
            exec ${lib.getExe pkgs.sway-contrib.grimshot} save screen - | ${lib.getExe pkgs.satty} --filename - --early-exit --fullscreen --copy-command ${pkgs.wl-clipboard}/bin/wl-copy
          '';
          "Control+Print" = ''
            exec ${lib.getExe pkgs.sway-contrib.grimshot} save area - | ${lib.getExe pkgs.satty} --filename - --early-exit --copy-command ${pkgs.wl-clipboard}/bin/wl-copy
          '';
          "${modifier}+Shift+Escape" =
            "exec ${lib.getExe pkgs.swaylock} -fF -i ${../files/wallpapers/LOCK.png} -u";
          "F9" = "exec ${lib.getExe pkgs.swaylock} -fF -i ${../files/wallpapers/LOCK.png} -u";
          "Shift+F9" = "exec ${lib.getExe pkgs.swaylock} -fF -i ${../files/wallpapers/LOCK.png} -u && systemctl suspend";
          "${modifier}+Control+Shift+h" = "move workspace to output left";
          "${modifier}+Control+Shift+l" = "move workspace to output right";
          "${modifier}+Control+Shift+k" = "move workspace to output up";
          "${modifier}+Control+Shift+j" = "move workspace to output down";
        };
      input = {
        "*" = {
          xkb_layout = "us,ru";
          xkb_options = "grp:win_space_toggle"; # map caps to escape.
        };
        "type:touchpad" = {
          natural_scroll = "enabled";
          tap = "enabled";
          dwt = "disabled";
          pointer_accel = "0.5"; # set mouse sensitivity (between -1 and 1)
        };
        "type:trackpoint" = {
          pointer_accel = "0.3"; # set mouse sensitivity (between -1 and 1)
        };
      };
    };
  };
}
