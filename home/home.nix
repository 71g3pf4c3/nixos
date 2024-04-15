{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  home.username = "t1g3pf4c3";
  home.homeDirectory = "/home/t1g3pf4c3";
  home.stateVersion = "23.11";
  home.packages = with pkgs; [
    comma
    manix
    ncdu
    telegram-desktop
    libsixel
    termplay
    kubectl
    fd
    tmux-xpanes
    wtf
    playerctl
    translate-shell
    tree-sitter
    postgresql
    mysql80
    webcord-vencord
    zoom-us
    popeye
    dig
    nodePackages.webtorrent-cli
    sxiv
    qbittorrent
    libreoffice
    drawio
    k8sgpt
    kube-capacity
    kubectl-tree
    kubectl-node-shell
    kubernetes-helm
    cargo
    nodejs
    buku
    bukubrow
    wdisplays
    gcc_multi
    xdragon
    wineWowPackages.waylandFull
    unzip
    python3
    pavucontrol
    restic
    stylua
    nixfmt-rfc-style
    shellcheck
    shellharden
    yq-go
    codespell
    gptcommit
    aichat
    python311Packages.pyclip
    rocketchat-desktop
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
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
    size = 22;
  };
  programs.home-manager.enable = true;
}
