{ config, pkgs, self, ... }: {
  imports = [ ./hardware-configuration.nix ./sway.nix ];
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
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  services = {
    openssh.enable = true;
    # open-fprintd.enable = true;
    # python-validity.enable = true;
    blueman.enable = true;
    #actkbd = {
    #  enable = true;
    #  bindings = [
    #    { keys = [ 224 ]; events = [ "key" "rep" ]; command = "light -U 10"; }
    #    { keys = [ 225 ]; events = [ "key" "rep" ]; command = "light -A 10"; }
    #  ];
    #};
    tlp = {
      enable = true;
      settings = {
        TLP_ENABLE = 1;
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 100;
        RESTORE_THRESHOLDS_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
        DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth wwan";
        DEVICES_TO_ENABLE_ON_STARTUP = "wifi";
        PCIE_ASPM_ON_BAT = "powersupersave";
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

  system.stateVersion = "22.11"; # Did you read the comment?

}
