{ config, pkgs, unstable, lib, inputs, ... }: {
  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "\${HOME}/.steam/root/compatibilitytools.d";
  };
  home.packages = with pkgs; [
    ncdu
    telegram-desktop
    nh
    nvd
    # kubectl
    # fd
    # tmux-xpanes
    # wtf
    # playerctl
    # translate-shell
    # tree-sitter
    # postgresql
    # mysql80
    # webcord-vencord
    # zoom-us
    # popeye
    # dig
    nodePackages.webtorrent-cli
    qbittorrent
    libreoffice
    drawio
    wineWowPackages.waylandFull
    bottles
    # k8sgpt
    # kube-capacity
    # kubectl-tree
    # kubectl-node-shell
    # kubernetes-helm
    # cargo
    # nodejs
    # buku
    # bukubrow
    # wdisplays
    # gcc_multi
    # xdragon
    # unzip
    # python3
    # pavucontrol
    # restic
    # stylua
    # nixfmt-rfc-style
    # shellcheck
    # shellharden
    # yq-go
    # codespell
    # gptcommit
    # aichat
    # python311Packages.pyclip
    # rocketchat-desktop
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
    webtorrent_desktop
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
    # libsixel
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
