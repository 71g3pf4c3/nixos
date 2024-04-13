{ config, pkgs, unstable, lib, inputs, ... }: {
  programs.mpv = {
    enable = true;
    config = {
      ytdl-format = "bestvideo[height<=?720][fps<=?30][vcodec!=?h264]+worstaudio/[acodec=opus][abr<=?70]";
      geometry = "40%+90%+10%";
      script-opts = "ytdl_hook-ytdl_path=${lib.getExe pkgs.yt-dlp}";
    };
  };
}
