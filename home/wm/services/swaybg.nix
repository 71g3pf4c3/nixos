{
  stdenv,
  config,
  pkgs,
  lib,
  ...
}:
let
  wallpaper = ../../appearance/wallpapers/struct3_sepia_nix.png;
in
{
  systemd.user.services.swaybg = {
    Unit = {
      Description = "Wayland wallpaper daemon";
      PartOf = [ "sway-session.target" ];
    };
    Service = {
      ExecStart = "${lib.getExe pkgs.swaybg} -i ${wallpaper} -m fill";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "sway-session.target"];
  };
}
