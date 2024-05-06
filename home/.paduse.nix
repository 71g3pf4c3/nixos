{
  config,
  pkgs,
  unstable,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./wm
    ./tools
  ];
  home.packages = with pkgs; [
    comma
    manix
    nh
    nvd
    ncdu
    telegram-desktop
    wl-clipboard
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
    # webcord
    vesktop
    zoom-us
    popeye
    dig
    # nodePackages.webtorrent-cli
    sxiv
    qbittorrent
    libreoffice
    drawio
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
    go
    restic
    stylua
    nixfmt-rfc-style
    shellcheck
    shellharden
    yq-go
    codespell
    # gptcommit
    aichat
    python311Packages.pyclip
    nix-index
    rocketchat-desktop
    luajitPackages.lua-utils-nvim
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

  services.flatpak.enable = true;
  services.flatpak.remotes = [
    {
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }
  ];
  services.flatpak.packages = [
    "org.apache.directory.studio"
  ];

}
