{ config, pkgs, self, lib, inputs, ... }: {
  documentation.man = {
    enable = true;
    generateCaches = true;
  };
  nix.settings.experimental-features = [ "nix-command flakes" ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "electron-22.3.27" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl = { "net.ipv4.ip_unprivileged_port_start" = 80; };
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
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
    127.0.0.1:80 kind
    127.0.0.1:443 kind
  '';
  i18n.defaultLocale = "en_US.UTF-8";
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall =
      true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall =
      true; # Open ports in the firewall for Source Dedicated Server
  };
  hardware.opengl.driSupport32Bit =
    true; # Enables support for 32bit libs that steam uses
  services.xserver = {
    enable = true;
    displayManager.defaultSession = "sway";
    desktopManager.xterm.enable = false;
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
  powerManagement = { enable = true; };
  virtualisation = {
    waydroid.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    libvirtd.enable = true;
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraSessionCommands =
      "	export SDL_VIDEODRIVER=wayland\n	export QT_QPA_PLATFORM=wayland\n	export QT_WAYLAND_DISABLE_WINDOWDECORATION=\"1\"\n	export _JAVA_AWT_WM_NONREPARENTING=1\n	export XDG_SESSION_TYPE=wayland\n	export XDG_CURRENT_DESKTOP=sway\n	export XDG_SESSION_DESKTOP=sway\n	export SDL_VIDEODRIVER=wayland\n";
  };
  system.stateVersion = "23.11"; # Did you read the comment?
services.udisks2.enable = true;
}
