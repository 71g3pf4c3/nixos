{ config, pkgs, unstable, lib, inputs, ... }: {
  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
      recolor-lightcolor = config.colorScheme.palette.base00;
      recolor-darkcolor = config.colorScheme.palette.base07;
      default-bg = config.colorScheme.palette.base07;
      highlight-color = config.colorScheme.palette.base09;
      highlight-active-color = config.colorScheme.palette.base0E;
      inputbar-fg = config.colorScheme.palette.base00;
      inputbar-bg = config.colorScheme.palette.base01;
      statusbar-fg = config.colorScheme.palette.base07;
      statusbar-bg = config.colorScheme.palette.base01;
      index-fg = config.colorScheme.palette.base07;
      index-bg = config.colorScheme.palette.base01;
      index-active-fg = config.colorScheme.palette.base07;
      index-active-bg = config.colorScheme.palette.base03;
      notification-bg = config.colorScheme.palette.base07;
      notification-fg = config.colorScheme.palette.base01;
      adjust-open = "width";
      recolor = true;
    };
  };
}
