{
  config,
  pkgs,
  unstable,
  lib,
  inputs,
  ...
}:
{
  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
      recolor-lightcolor = config.colorScheme.palette.darkfg;
      recolor-darkcolor = config.colorScheme.palette.darkbg;
      default-bg = config.colorScheme.palette.darkbg;
      highlight-color = config.colorScheme.palette.darkorange;
      highlight-active-color = config.colorScheme.palette.darkpurple;
      inputbar-fg = config.colorScheme.palette.darkfg;
      inputbar-bg = config.colorScheme.palette.darkbg1;
      statusbar-fg = config.colorScheme.palette.darkfg;
      statusbar-bg = config.colorScheme.palette.darkbg1;
      index-fg = config.colorScheme.palette.darkfg;
      index-bg = config.colorScheme.palette.darkbg1;
      index-active-fg = config.colorScheme.palette.darkfg0;
      index-active-bg = config.colorScheme.palette.darkbg4;
      notification-bg = config.colorScheme.palette.darkfg0;
      notification-fg = config.colorScheme.palette.darkbg4;
      adjust-open = "width";
      recolor = true;
    };
  };
}
