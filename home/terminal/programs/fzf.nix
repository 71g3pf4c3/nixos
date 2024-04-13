{ config, pkgs, unstable, lib, inputs, ... }: {
  programs.fzf = {
    enable = true;
    defaultCommand = "${pkgs.fd}/bin/fd --strip-cwd-prefix --hidden --follow --exclude .git";
    fileWidgetOptions = [
      "--bind=alt-k:up,alt-j:down"
      "--preview '${lib.getExe pkgs.pistol} {}'"
    ];
  };
}
