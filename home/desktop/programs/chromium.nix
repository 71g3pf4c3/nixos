{ ... }: {
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--ozone-platform-hint=wayland"
    ];
    extensions = [
      { id = "ghniladkapjacfajiooekgkfopkjblpn"; } # bukbrow
      { id = "fddjpichkajmnkjhcmpbbjdmmcodnkej"; } # rutracker
      { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # sponsorblock
      { id = "kefjpfngnndepjbopdmoebkipbgkggaa"; } # rss hub
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "aleakchihdccplidncghkekgioiakgal"; } # h264ify
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
      { id = "amddgdnlkmohapieeekfknakgdnpbleb"; } # xtab
      { id = "omkfmpieigblcllmkgbflkikinpkodlk"; } # enchanced h264ify
    ];
  };
}
