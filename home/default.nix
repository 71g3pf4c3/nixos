{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    inputs.nix-colors.homeManagerModules.default
    inputs.nix-colors.homeManagerModules.default
    inputs.xremap-flake.homeManagerModules.default
    ./terminal
    ./desktop
    ./appimage
    ./flatpak
    ./appearance/colors
    ./home.nix
    ./xdg.nix
    ./wm
  ];
  home.packages = with pkgs; [
    nh
    ncdu
    libsixel
    wtfutil
    playerctl
    translate-shell
    dig
    bukubrow
    # gcc_multi
    wineWowPackages.waylandFull
    unzip
    libreoffice
    yq-go
    flatpak
    # termplay
    # fd
    # tmux-xpanes
    # qbittorrent
    # rocketchat-desktop
    # gptcommit
    # aichat
    # python311Packages.pyclip
    # nix-index
    # nodePackages.webtorrent-cli
    # webcord
    # vesktop
    # assh
    # alejandra
    # vieb
    # cool-retro-term
    # openssl
    # pango
    # pastel
    # glab
    # winbox
    # kubectl
    # kubectl-explore
    # kubectl-example
    # webtorrent_desktop
    # kubectl-view-allocations
    # gimp
    # autossh
    # dig
    # yq-go
    # podman-tui
    # bluetuith
    # wemux
    # frp
    # cli superpowers
    # entr
    # gptcommit
    # gotty
    # sshpass
    # ttyd
    # tmux-cssh
    # prog
    # trivy
    # apache-directory-studio
    # jira-cli-go
    # doctl
    # dbeaver
    #nix tools
    # nixos-container
    # slack
    # lnav
    # kubespy
    # distrobox
    # shortcut
    # google-chrome
    # firefox
    # zap
    # jmeter
    # python311Packages.selenium
    # ozr
    # clipman
    # clipboard-jh
    # wineWowPackages.fonts
    # grafterm
    # git-annex
    # wireshark
    # mosh
    # pueue
    # pulsemixer
    # freerdp
    # vhs
    # keystore-explorer
    # discord
    # thunderbird
  ];

}
