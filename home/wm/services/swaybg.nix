{ config, pkgs, unstable, lib, inputs, ... }: {
  systemd.user.services.swaybg = {
    Unit = {
      Description = "Wayland wallpaper daemon";
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${
        lib.getExe pkgs.swaybg
      } -i ${config.home.homeDirectory}/etc/wallpapers/struct3_sepia_nix.png -m fill";
      Restart = "on-failure";
    };
    Install.WantedBy = ["graphical-session.target"];
  };
}
