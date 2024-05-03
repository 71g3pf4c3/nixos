{
  config,
  pkgs,
  self,
  lib,
  inputs,
  ...
}:
{
  imports = [ ./sway.nix ];
  documentation.man = {
    enable = true;
    generateCaches = true;
  };
  nix.settings.experimental-features = [ "nix-command flakes" ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "electron-22.3.27" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl = {
    "net.ipv4.ip_unprivileged_port_start" = 80;
  };
  networking.hostName = "paduse";
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.enable = true;
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
  hardware.opengl.driSupport32Bit = true; # Enables support for 32bit libs that steam uses
  services.xserver = {
    enable = true;
    desktopManager.xterm.enable = false;
  };
  services.displayManager.defaultSession = "sway";
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
  powerManagement = {
    enable = true;
  };
  virtualisation = {
    waydroid.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    libvirtd.enable = true;
  };
  system.stateVersion = "23.11"; # Did you read the comment?
  services.udisks2.enable = true;
  services.guix.enable = false;
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          capslock = "overload(control, esc)";
          rightalt = "layer(rightalt)";
          control = "oneshot(control)";
          alt = "oneshot(alt)";
          shift = "oneshot(shift)";
          meta = "oneshot(meta)";
        };
        rightalt = {
          h = "left";
          j = "down";
          k = "up";
          l = "right";
          u = "PageUp";
          d = "PageDown";
        };
      };
    };
  };
}
