{ config, pkgs, self, lib, inputs, ... }: {
  imports = [ ./hardware-configuration.nix ./sway.nix ];
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
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable =
    true; # Easiest to use and most distros use this by default. Set your time zone.

  networking.firewall.enable = false;
  time.timeZone = "Europe/Moscow";
  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 10d";
  };
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';
  networking.extraHosts = ''
    127.0.0.3 cluster-example.mysql.svc.cluster.local
    127.0.0.1:80 kind
    127.0.0.1:443 kind
  '';
  i18n.defaultLocale = "en_US.UTF-8";
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs;
    [

    ];
  # programs.neovim = {
  #   enable = true;
  #   defaultEditor = true;
  # };
  programs.steam = {
    enable = true;
    remotePlay.openFirewall =
      true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall =
      true; # Open ports in the firewall for Source Dedicated Server
  };
  hardware.opengl.driSupport32Bit =
    true; # Enables support for 32bit libs that steam uses

  # Enable the X11 windowing system.
  programs.light.enable = true;
  services.xserver = {
    enable = true;
    displayManager.defaultSession = "sway";
    desktopManager.xterm.enable = false;
  };
  security.polkit.enable = true;
  security.pki.certificates = [''
    -----BEGIN CERTIFICATE-----
    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
    OOLCIQcLBs6pxp5ZPA9UAQpZSGaq
    -----END CERTIFICATE-----
  ''];
  services.printing.enable = true;
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  users.defaultUserShell = pkgs.zsh;
  users.groups = { docker = { }; };
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
    # nixos-shell
    pamixer
    podman-compose
    lm_sensors
    neovim
    wget
    htop
    virt-manager
    # undervolt
  ];

  programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # pinentryPackage = lib.mkForce pkgs.pinentry-gnome3;
  # };

  services = {
    openssh.enable = true;
    blueman.enable = true;
    thermald.enable = true;
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          ideapad_laptop_conservation_mode = true;
          enable_thresholds = true;
          start_threshold = 80;
          stop_threshold = 85;
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
    tlp = {
      enable = false;
      settings = {
        TLP_ENABLE = 1;
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 95;
        RESTORE_THRESHOLDS_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_AC = "";
        CPU_SCALING_GOVERNOR_ON_BAT = "";
        DEVICES_TO_DISABLE_ON_STARTUP = "wwan";
        DEVICES_TO_ENABLE_ON_STARTUP = "wifi bluetooth";
        PCIE_ASPM_ON_BAT = "powersupersave";
        NATACPI_ENABLE = "1";
        TPACPI_ENABLE = "1";
        TPSMAPI_ENABLE = "1";
        SOUND_POWER_SAVE_ON_AC = "0";
        SOUND_POWER_SAVE_ON_BAT = "1";
        WIFI_PWR_ON_AC = "off";
        WIFI_PWR_ON_BAT = "on";
        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "low-power";
        DEVICES_TO_DISABLE_ON_BAT = "";
      };
    };
  };
  powerManagement = {
    enable = true;
    # powertop.enable = true;
  };
  virtualisation = {
    waydroid.enable = true;
    # docker.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    libvirtd.enable = true;
  };

  programs.dconf.enable = true;

  # system.copySystemConfiguration = true;

  system.stateVersion = "23.11"; # Did you read the comment?
  # services.grafana = {
  #   enable = true;
  #   settings = {
  #     server = {
  #       domain = "nixos";
  #       port = 2342;
  #       addr = "127.0.0.1";
  #     };
  #   };
  #   provision = {
  #     datasources = {
  #       settings = {
  #         datasources = [{
  #           name = "prometheus";
  #           type = "prometheus";
  #           url = "http://localhost:9001";
  #         }];
  #       };
  #
  #     };
  #
  #   };
  # };
  # services.prometheus = {
  #   enable = true;
  #   port = 9001;
  #   exporters = {
  #     node = {
  #       enable = true;
  #       enabledCollectors = [ "systemd" "cgroups" "interrupts" "sysctl" "tcpstat" "buddyinfo" ];
  #       port = 9002;
  #     };
  #     smokeping = {
  #       enable = true;
  #       port = 9003;
  #       hosts = [ "reg.ru" "web-bee.ru" "moskit.pro" "nic.ru" "8.8.8.8" "192.168.0.1" "yandex.ru" "77.88.8.8" ];
  #     };
  #   };
  #   scrapeConfigs = [
  #     {
  #       job_name = "kube-state-metrics";
  #       static_configs = [{
  #         targets = [
  #           "127.0.0.1:8080"
  #         ];
  #       }];
  #     }
  #     {
  #       job_name = "node";
  #       static_configs = [{
  #         targets = [
  #           "127.0.0.1:9002"
  #         ];
  #       }];
  #     }
  #     {
  #       job_name = "smokeping";
  #       static_configs = [{
  #         targets = [ "127.0.0.1:9003" ];
  #       }];
  #     }
  #   ];
  # };
  # services.ratbagd.enable = true;
  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;
    plugins.lightline.enable = true;
  };
}
