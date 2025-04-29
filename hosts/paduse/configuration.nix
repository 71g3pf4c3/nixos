{
  config,
  pkgs,
  self,
  lib,
  inputs,
  ...
}:
{
  documentation.man = {
    enable = false;
    generateCaches = false;
  };
  nix.settings.experimental-features = [ "nix-command flakes" ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "electron-22.3.27" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl = {
    "net.ipv4.ip_unprivileged_port_start" = 0;
  };
  networking.hostName = "paduse";
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.enable = true;
  networking.firewall.allowPing = true;
  time.timeZone = "Europe/Moscow";
  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix.extraOptions = ''
    keep-outputs = false
    keep-derivations = false
  '';
  networking.extraHosts = ''
    127.0.0.1 kind
    127.0.0.1 kind
    172.18.0.1 grafana.localhost
    172.18.0.2 grafana.localhost
    172.18.0.3 grafana.localhost
    172.18.0.4 grafana.localhost
    172.18.0.5 grafana.localhost
    172.18.0.6 grafana.localhost
    172.18.0.7 grafana.localhost
    172.18.0.8 grafana.localhost
    172.18.0.9 grafana.localhost
    172.18.0.1 ingress.localhost
    172.18.0.2 ingress.localhost
    172.18.0.3 ingress.localhost
    172.18.0.4 ingress.localhost
    172.18.0.5 ingress.localhost
    172.18.0.6 ingress.localhost
    172.18.0.7 ingress.localhost
    172.18.0.8 ingress.localhost
    172.18.0.9 ingress.localhost
    172.18.0.1 kind.localhost
    172.18.0.2 kind.localhost
    172.18.0.3 kind.localhost
    172.18.0.4 kind.localhost
    172.18.0.5 kind.localhost
    172.18.0.6 kind.localhost
    172.18.0.7 kind.localhost
    172.18.0.8 kind.localhost
    172.18.0.9 kind.localhost
    172.18.0.1 grafana.localhost
    172.18.0.2 grafana.localhost
    172.18.0.3 grafana.localhost
    172.18.0.4 grafana.localhost
    172.18.0.5 grafana.localhost
    172.18.0.6 grafana.localhost
    172.18.0.7 grafana.localhost
    172.18.0.8 grafana.localhost
    172.18.0.9 grafana.localhost
    172.18.0.1 keycloak.localhost
    172.18.0.2 keycloak.localhost
    172.18.0.3 keycloak.localhost
    172.18.0.4 keycloak.localhost
    172.18.0.5 keycloak.localhost
    172.18.0.6 keycloak.localhost
    172.18.0.7 keycloak.localhost
    172.18.0.8 keycloak.localhost
    172.18.0.9 keycloak.localhost
  '';
  i18n.defaultLocale = "en_US.UTF-8";
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ ];
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  hardware.graphics.enable32Bit = true; # Enables support for 32bit libs that steam uses
  services.xserver = {
    enable = true;
    desktopManager.xterm.enable = false;
  };
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
    };
    defaultSession = "sway";
  };
  security.polkit.enable = true;
  services.printing.enable = true;
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.t1g3pf4c3 = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAoEHHbqoioIXbk6bsQHEhiT1mYMShboCY27BvdXkJFg t1g3pf4c3@nixos"
    ];
    isNormalUser = true;
    home = "/home/t1g3pf4c3";
    extraGroups = [
      "lxd"
      "wheel"
      "root"
      "networkmanager"
      "audio"
      "docker"
      "qemu"
      "libvirtd"
      "realtime"
      "video"
      "libvirtd"
      "qemu-libvirtd"
    ];
  };
  environment.systemPackages = with pkgs; [
    man-pages
    man-pages-posix
    alsa-utils
    git
    pamixer
    podman-compose
    lm_sensors
    wget
    htop
    virt-manager
  ];
  services = {
    dbus = {
      enable = true;
      implementation = "broker";
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    openssh.enable = true;
    blueman.enable = true;
    thermald.enable = true;
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          enable_thresholds = true;
          start_threshold = 60;
          stop_threshold = 85;
          scaling_min_freq = 800000;
          governor = "schedutil";
          turbo = "auto";
          energy_performance_preference = "power";
        };
        charger = {
          ideapad_laptop_conservation_mode = false;
          governor = "performance";
          energy_performance_preference = "performance";
          turbo = "auto";
        };
      };
    };
  };
  virtualisation = {
    waydroid.enable = true;
    docker = {
      enable = true;
    };
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    libvirtd.enable = true;
  };
  system.stateVersion = "23.11"; # Did you read the comment?
  services.udisks2.enable = true;
  services.guix.enable = false;
  # services.monero = {
  #   enable = true;
  #   mining = {
  #     enable = true;
  #     address = "49gjMmiHFkoXh73R8e5TopGHQ4PaGuambUuh1PYbaJ51Xfafz4XBdPRBcxxG3akKnCTdgQvWqB1hrSbqtvhW8qJwDSryQSP";
  #   };
  # };
  # services.keyd = {
  #   enable = true;
  #   keyboards.default = {
  #     ids = [ "*" ];
  #     settings = {
  #       main = {
  #         capslock = "overload(control, esc)";
  #         rightalt = "layer(rightalt)";
  #         # control = "oneshot(control)";
  #         # alt = "oneshot(alt)";
  #         # shift = "oneshot(shift)";
  #         # meta = "oneshot(meta)";
  #       };
  #       rightalt = {
  #         h = "left";
  #         j = "down";
  #         k = "up";
  #         l = "right";
  #         u = "PageUp";
  #         d = "PageDown";
  #       };
  #     };
  #   };
  # };
  hardware.uinput.enable = true;
  users.groups.uinput.members = [ "t1g3pf4c3" ];
  users.groups.input.members = [ "t1g3pf4c3" ];

  # services.samba = {
  #   enable = true;
  #   securityType = "user";
  #   openFirewall = true;
  #   settings = {
  #     global = {
  #       "workgroup" = "WORKGROUP";
  #       "server string" = "smbnix";
  #       "netbios name" = "smbnix";
  #       "security" = "user";
  #       #"use sendfile" = "yes";
  #       #"max protocol" = "smb2";
  #       # note: localhost is the ipv6 localhost ::1
  #       "hosts allow" = "192.168.1. 192.168.0. 127.0.0.1 localhost";
  #       "hosts deny" = "0.0.0.0/0";
  #       "guest account" = "nobody";
  #       "map to guest" = "bad user";
  #     };
  #     "public" = {
  #       "path" = "/home/t1g3pf4c3/var/local/share";
  #       "browseable" = "yes";
  #       "read only" = "no";
  #       "guest ok" = "yes";
  #       "create mask" = "0644";
  #       "public" = "yes";
  #       "directory mask" = "0755";
  #       "force user" = "t1g3pf4c3";
  #       "force group" = "wheel";
  #     };
  #   };
  # };
  # networking.firewall.extraCommands = ''iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns'';
}
