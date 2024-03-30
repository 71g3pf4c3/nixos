{
  config,
  pkgs,
  self,
  lib,
  inputs,
  ...
}: {
  documentation.man = {
    enable = true;
    generateCaches = true;
  };
  nix.settings.experimental-features = ["nix-command flakes"];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = ["electron-22.3.27"];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl = {"net.ipv4.ip_unprivileged_port_start" = 80;};
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
  programs.nix-ld.libraries = with pkgs; [];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall =
      true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall =
      true; # Open ports in the firewall for Source Dedicated Server
  };
  hardware.opengl.driSupport32Bit =
    true; # Enables support for 32bit libs that steam uses
  programs.light.enable = true;
  services.xserver = {
    enable = true;
    displayManager.defaultSession = "sway";
    desktopManager.xterm.enable = false;
  };
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraSessionCommands = "	export SDL_VIDEODRIVER=wayland\n	export QT_QPA_PLATFORM=wayland\n	export QT_WAYLAND_DISABLE_WINDOWDECORATION=\"1\"\n	export _JAVA_AWT_WM_NONREPARENTING=1\n	export XDG_SESSION_TYPE=wayland\n	export XDG_CURRENT_DESKTOP=sway\n	export XDG_SESSION_DESKTOP=sway\n	export SDL_VIDEODRIVER=wayland\n";
  };
  security.polkit.enable = true;
  services.printing.enable = true;
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.t1g3pf4c3 = {
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDM3LX8F/SYt9fDPr0lR1/bDfwNT2mSgTLA8jxoIN63iKzPfDbeeyuLajSBbyZAWy+DjqLKL+htyLORSOWciaIzWkDNUN+9ikCLj3FDbk0Dl8vsgyzGrAoAnaf6Tc3JhhQuk+L68Q36I8ytJgLz0rleSl+Em2nilNlj07RJXqnDTuQXxh3CIfQc2z8EYJX0rWcJy2q4Bg2sHwifOH+MbWTg6M1G7MxoE3uyOp6yJeLAT2qi7cE7auHP02fDKeRgxPOeJ9FEV24b475htiQjgcXOIAFjAZ/+i3xpREue7prPDwHBfEzJNHYOT+FsrB24hXbGgTO8C67lyoWbGFAOlcJIDsZ9reYELlhe4lTDRrdcSK+pqRCPvHng7yw2y5D71j8d9nzcdBf/t7lww4OjPIOlU5yph2ng2WyxBXM7jQ/l9pbKaBzEwGlkHK209pdNFaeBKS8xmouCYNbimLNMjxV6CQ02BlhAH+AAeJu3ZfLZQbU7oT8T4spTWcT86+w8R/OMCWV45ZWSoZpj+e7Qfmu9cR8vXryjt/FaklOIRFz082bpbYKNOorEOD/R8veECVA2fAjKt70BsuzGC3QvqaSJPWPVGPZA+ZNY5Jty4w5UwcNCbPCdW2wvkZcp57c5boYxIm3PEK18RzFJ+PsAnZJxNE53FRZKcaPcEvraufDtkQ== t1g3pf4c3@pop-os" # content of authorized_keys file
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
          governor = "powersave";
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
  powerManagement = {enable = true;};
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
}
