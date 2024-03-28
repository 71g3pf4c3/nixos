{ pkgs, ... }:
let
  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts
  # some user services to make sure they have the correct environment variables
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;
    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };

  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'Gruvbox'
    '';
  };
in {
  environment.systemPackages = with pkgs; [
    sway
    dbus-sway-environment
    configure-gtk
    wayland
    slurp
    xdg-utils # for opening default programs when clicking links
    glib # gsettings
    gnome3.adwaita-icon-theme # default gnome cursors
    swaylock
    swayidle
    wayshot # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system developed by swaywm maintainer
    wdisplays # tool to configure displays
    swaybg
  ];
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.dbus.enable = true;
  services.dbus.implementation = "broker";
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
}
