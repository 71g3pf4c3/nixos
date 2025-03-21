{
  ...
}:
{

  programs.yazi = {
    enable = true;
    settings = {
      plugins = {
        session = ./plugins/session.lua;
      };
    };
  };
}
