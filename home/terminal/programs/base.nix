{
  config,
  pkgs,
  unstable,
  lib,
  inputs,
  ...
}:
{
  programs = {
    ripgrep.enable = true;
    gpg.enable = true;
    jq.enable = true;
    lazygit.enable = true;
    watson.enable = true;
    htop.enable = true;
    zoxide.enable = true;
    eza.enable = true;
    atuin = {
      enable = true;
      settings = {
        keymap_mode = "vim-normal";
        enter_accept = true;
        # inline_height = 30;
      };
    };
    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };
    password-store = {
      enable = true;
      settings = {
        PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.password-store";
        PASSWORD_STORE_CLIP_TIME = "60";
      };
    };
  };
  home.packages = with pkgs; [
    # step-ca
    # step-cli
    distrobox
    assh
    # terraform
    # ansible
    # hubble
    # argocd
    mysql80
    # zoom-us
    # glab
    # gnumake
    # goss
    # postgresql
    # s3cmd
    # s4cmd
    openssl
  ];
}
