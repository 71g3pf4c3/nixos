{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    rclone-ui
  ];
  programs.rclone = {
    enable = true;
    # remotes = [
    #   {
    #    type = "yandex";
    #   }
    # ];
  };
}
