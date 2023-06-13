{ config, pkgs, self, lib, ... }: {
  imports = [ ./hardware-configuration.nix ./sway.nix ];
  # stylix.image = /home/t1g3pf4c3/pictures/wallpapers/struct3_sepia_nix.png;
  security.pam.services.swaylock.text = ''
    # Account management.
    account required pam_unix.so

    # Authentication management.
    auth sufficient pam_unix.so   likeauth try_first_pass nullok
    auth sufficient ${self.inputs.nixos-06cb-009a-fingerprint-sensor.localPackages.fprintd-clients}/lib/security/pam_fprintd.so
    auth required pam_deny.so

    # Password management.
    password sufficient pam_unix.so nullok sha512

    # Session management.
    session required pam_env.so conffile=/etc/pam/environment readenv=0
    session required pam_unix.so
  '';
  nixpkgs.overlays = [ self.inputs.nix-alien.overlays.default ];
  nix.settings.experimental-features = [ "nix-command flakes" ];
  nixpkgs.config.allowUnfree = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable =
    true; # Easiest to use and most distros use this by default. Set your time zone.
  networking.firewall.enable = false;
  time.timeZone = "Europe/Moscow";
  # Configure network proxy if necessary
  # networking.proxy.default = "http://10.7.1.38:3128/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,web-bee.loc,betiz.loc,telecom.loc,46.101.187.23,10.114.0.0/20,10.8.8.0/24";
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';
  networking.extraHosts = ''
      10.8.8.14 t4sus-telecom
    	10.200.200.64 t4sus-webbee
    	192.168.1.227 t4sus
  '';

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  programs.steam.enable = true;
  programs.nix-ld.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  # Enable the X11 windowing system.
  programs.light.enable = true;
  services.flatpak.enable = true;
  services.xserver = {
    enable = true;
    displayManager.defaultSession = "sway";
    desktopManager.xterm.enable = false;
  };
	# programs.hyprland.enable = true;

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
    git
    nix-alien
    nixos-shell
    pamixer
    podman-compose
    lm_sensors
    neovim
    wget
    htop
    virt-manager
    undervolt
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # sound.mediaKeys.enable = true;
  services = {
    openssh.enable = true;
    open-fprintd.enable = true;
    python-validity.enable = true;
    blueman.enable = true;
    # actkbd = {
    #   enable = true;
    #   bindings = [
    #     { keys = [ 224 ]; events = [ "key" "rep" ]; command = "${lib.getExe pkgs.light} -U 2"; }
    #     { keys = [ 225 ]; events = [ "key" "rep" ]; command = "${lib.getExe pkgs.light} -A 2"; }
    #   ];
    # };
    tlp = {
      enable = true;
      settings = {
        TLP_ENABLE = 1;
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 95;
        RESTORE_THRESHOLDS_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
        DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth wwan";
        DEVICES_TO_ENABLE_ON_STARTUP = "wifi";
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
        DEVICES_TO_DISABLE_ON_BAT = "bluetooth";
      };
    };
  };
  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = "schedutil";
  };
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    libvirtd.enable = true;

  };

  programs.dconf.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  system.stateVersion = "23.05"; # Did you read the comment?

}
