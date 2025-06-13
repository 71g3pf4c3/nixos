{
  config,
  pkgs,
  unstable,
  lib,
  inputs,
  ...
}:
{
  systemd.user.services.xremap.Install.WantedBy = [ "sway-session.target" ];
  services.xremap = {
    enable = true;
    withWlroots = true;
    # deviceNames = [
    #   "Lenovo ThinkPad Compact USB Keyboard with TrackPoint"
    #   "AT Translated Set 2 keyboard"
    # ];
    config = {
      keymap = [
        {
          name = "Language";
          remap = {
            RIGHTALT = "LEFTMETA-SPACE";
          };
        }
        {
          name = "Chromium";
          application = {
            only = [
              "chromium-browser"
              "Vivaldi-stable"
              "org.telegram.desktop"
              "rocket.chat"
            ];
          };
          remap = {
            Alt-j = "down";
            Alt-k = "up";
            Alt-h = "left";
            Alt-l = "right";
            Alt-t = "C-Tab";
            Alt-g = "HOME";
            Alt-Shift-g = "END";
            Alt-Shift-t = "C-Shift-Tab";
            Alt-e = "C-t";
            Alt-x = "C-w";
            Alt-d = "PAGEDOWN";
            Alt-u = "PAGEUP";
          };
        }
      ];
      modmap = [
        {
          name = "Global";
          remap = {
            CapsLock = {
              alone = "Esc";
              held = "LEFTSHIFT";
              alone_timeout_millis = 150;
            };
          };
        }
      ];
    };
  };
}
