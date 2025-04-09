{
  config,
  pkgs,
  unstable,
  lib,
  inputs,
  ...
}:
{
  programs.git = {
    enable = true;
    includes = [
      {
        contents = {
          user = {
            email = "kungurov.m@selectel.ru";
            name = "Makar Kungurov";
          };
        };
      }
      {
        contents = {
          user = {
            email = "71g3pf4c3@gmail.com";
            name = "71g3pf4c3";
          };
        };
      }
    ];
    delta = {
      enable = false;
      options = {
        side-by-side = true;
        line-numbers = true;
        syntax-theme = "${config.colorScheme.slug}";
      };
    };
  };
}
