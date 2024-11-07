{
  config,
  pkgs,
  unstable,
  lib,
  inputs,
  ...
}:
{
  xdg.mime.enable = true;
  xdg.mimeApps = {
    enable = true;
  };
  xdg.userDirs = {
    desktop = "${config.home.homeDirectory}/tmp";
    download = "${config.home.homeDirectory}/tmp/downloads";
    pictures = "${config.home.homeDirectory}/var/pictures";
    documents = "${config.home.homeDirectory}/var/docs";
  };
  xdg.desktopEntries = {
    vesktop = {
      name = "Vesktop";
      exec = "${lib.getExe pkgs.vesktop}";
    };
    ktalk = {
      name = "Ktalk";
      exec = "${lib.getExe pkgs.appimage-run} /home/t1g3pf4c3/var/local/bin/ktalk2.12.0x86_64.AppImage";
    };
  };
}
