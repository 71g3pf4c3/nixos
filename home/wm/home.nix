{
  config,
  pkgs,
  ...
}:
{
  home.file."${config.home.homeDirectory}/.local/share/fonts" = {
    source = ./files/fonts;
    recursive = true;
  };
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
    size = 22;
  };
}
