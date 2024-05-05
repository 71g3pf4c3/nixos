{ config, pkgs, unstable, lib, inputs, ... }: {
    services.swayidle = {
      enable = true;
      systemdTarget = "sway-session.target";
      events = [
        {
          event = "before-sleep";
          command = "${pkgs.swaylock}/bin/swaylock -fF";
        }
      ];
      timeouts = [
        {
          timeout = 60 * 3;
          command = "${lib.getExe pkgs.swaylock} -fF";
        }
        {
          timeout = 60 * 2;
          command = "${lib.getExe pkgs.brightnessctl} set 10%-";
          resumeCommand = "${lib.getExe pkgs.brightnessctl} set 10%+";
        }
        {
          timeout = 60 * 10;
          command = "systemctl suspend";
        }
      ];
    };
}
