{ config, pkgs, unstable, lib, inputs, ... }: {
    services.swayidle = {
      enable = true;
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
          command = "${lib.getExe pkgs.light} -U 30";
          resumeCommand = "${lib.getExe pkgs.light} -A 30";
        }
      ];
    };
}
