{ config, pkgs, unstable, lib, inputs, ... }: {
  programs.rofi = {
    # plugins = with pkgs; [ rofi-emoji rofi-calc ];
    package = pkgs.rofi-wayland;
    enable = true;
    theme = "gruvbox-light";
    terminal = "${lib.getExe pkgs.foot}";
    pass = {
      enable = true;
      stores = [ "${config.home.homeDirectory}/.password-store" ];
      package = pkgs.rofi-pass-wayland;
      extraConfig = ''
        delay=0.001
        wait=0.001
        type_delay=1
        auto_enter='true'
        default_autotype='pass'
        clip_clear=3
        default_do='typePass'
      '';
    };
    extraConfig = {
      kb-primary-paste = "Control+V,Shift+Insert";
      kb-secondary-paste = "Control+v,Insert";
    };
  };
}
