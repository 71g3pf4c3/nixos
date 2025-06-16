{
  pkgs,
  ...
}:
{
  services.restic = {
    enable = true;
  };
}
