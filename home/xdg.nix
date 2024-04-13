{ config, pkgs, unstable, lib, inputs, ... }: {
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
}
