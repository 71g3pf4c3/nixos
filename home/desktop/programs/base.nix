{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    pavucontrol
    opentabletdriver
    imv
    wdisplays
    wl-clipboard
    qbittorrent
    snx-rs
  ];
  # systemd.user.services.mpris-proxy = {
  #     description = "Mpris proxy";
  #     after = [ "network.target" "sound.target" ];
  #     wantedBy = [ "default.target" ];
  #     serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  # };
}
