{ config, pkgs, unstable, lib, inputs, ... }: {
  programs.bat = {
    enable = true;
    config = {
      theme = "gruvbox-light";
      map-syntax = [
        "*.jenkinsfile:Groovy"
        "*Jenkinsfile:Groovy"
      ];
      pager = "${lib.getExe pkgs.less} -FR";
    };
  };
}
