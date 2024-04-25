{ config, pkgs, unstable, lib, inputs, ... }: {
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--ozone-platform-hint=wayland"
    ];
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "aleakchihdccplidncghkekgioiakgal"; } # h264ify
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
      { id = "jhnleheckmknfcgijgkadoemagpecfol"; } # auto tab discard
      { id = "bfidboloedlamgdmenmlbipfnccokknp"; } # purevpn
      { id = "amddgdnlkmohapieeekfknakgdnpbleb"; } # xtab
      { id = "omkfmpieigblcllmkgbflkikinpkodlk"; } # enchanced h264ify
    ];
  };
}
