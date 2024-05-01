{
  config,
  pkgs,
  lib,
  ...
}:
{
  systemd.user.services.swaybg = {
    Unit = {
      Description = "Wayland wallpaper daemon";
      PartOf = [ "sway-session.target" ];
    };
    Service = {
      ExecStart = "${lib.getExe pkgs.swaybg} -i ${config.home.homeDirectory}/etc/wallpapers/struct3_sepia_nix.png -m fill";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "sway-session.target"];
  };
}
