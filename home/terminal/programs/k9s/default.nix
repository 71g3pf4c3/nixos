{
  config,
  pkgs,
  unstable,
  lib,
  inputs,
  ...
}:
{
  programs.k9s = {
    enable = true;
    aliases = {
      aliases = {
        p = "v1/pods";
        n = "v1/namespaces";
        c = "context";
        d = "deployments";
        s = "v1/secrets";
        j = "jobs";
        r = "roles";
        rb = "rolebindings";
        np = "networkpolicies";
      };
    };
    settings = {
      k9s = {
        refreshRate = 3;
        liveViewAutoRefresh = true;
        disablePodCounting = false;
        ui = {
          skin = "gruvbox-light";
          enableMouse = false;
          headless = true;
          logoless = true;
          crumbsless = true;
          reactive = true;
          noIcons = true;
        };
        logger = {
          tail = 400;
          buffer = 5000;
          sinceSeconds = -200;
          fullScreen = true;
          textWrap = true;
          showTime = true;
        };
      };
    };
  };
  home.file."${config.home.homeDirectory}/.config/k9s/skins/gruvbox-light.yaml" = {
    source = ./gruvbox-light.yaml;
  };
  home.file."${config.home.homeDirectory}/.config/k9s/plugins" = {
    source = ./files/plugins;
    recursive = true;
  };
}
