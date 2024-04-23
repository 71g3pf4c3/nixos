{ config, pkgs, unstable, lib, inputs, ... }: {
  programs.pistol = {
    enable = true;
    associations = [
      {
        fpath = ".*.md$";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${lib.getExe pkgs.bat} --style=numbers,grid --paging=never --color=always %pistol-filename%";
      }
      {
        fpath = ".*.pem$";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${lib.getExe pkgs.openssl} x509 -text -noout -in %pistol-filename% || ${lib.getExe pkgs.bat} --style=numbers,grid %pistol-filename%";
      }
      {
        fpath = ".*.crt$";
        command = "sh:   ${lib.getExe pkgs.bkt} --ttl=30s -- ${lib.getExe pkgs.openssl} x509 -text -noout -in %pistol-filename% || ${lib.getExe pkgs.bat} --style=numbers,grid %pistol-filename%";
      }
      {
        fpath = ".*.csr$";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${lib.getExe pkgs.openssl} x509 -text -noout -in %pistol-filename% || ${lib.getExe pkgs.bat} --style=numbers,grid %pistol-filename%";
      }
      {
        fpath = ".*.md$";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${lib.getExe pkgs.bat} --style=numbers,grid --paging=never --color=always %pistol-filename% ";
      }
      {
        fpath = ".*.ini$";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${lib.getExe pkgs.bat} --style=numbers,grid --paging=never --color=always %pistol-filename% ";
      }
      {
        fpath = ".*.norg$";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${lib.getExe pkgs.bat} --style=numbers,grid --paging=never --color=always %pistol-filename% ";
      }
      {
        fpath = ".*.log$";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${lib.getExe pkgs.lnav} %pistol-filename%";
      }
      {
        fpath = ".*.docx";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${lib.getExe pkgs.python311Packages.docx2txt} %pistol-filename%";
      }
      {
        fpath = ".*.odt";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${lib.getExe pkgs.odt2txt} %pistol-filename%";
      }
      {
        fpath = ".*.zip";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${lib.getExe pkgs.unzip} -l %pistol-filename%";
      }
      {
        fpath = ".*.tar.*";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${lib.getExe pkgs.gnutar} -tavf %pistol-filename%";
      }
      {
        fpath = ".*.torrent";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${lib.getExe pkgs.nodePackages.webtorrent-cli} info %pistol-filename%";
      }
      {
        mime = "image/*";
        command = "sh: ${lib.getExe pkgs.chafa} -O 9 --passthrough tmux %pistol-filename%";
      }
      {
        mime = "video/*";
        command = "sh: ${lib.getExe pkgs.termplay} -q %pistol-filename%";
      }
      {
        mime = "application/*";
        command = "${lib.getExe pkgs.eza} %pistol-filename%";
      }
      {
        mime = "application/json";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${lib.getExe pkgs.jq} '.' %pistol-filename% ";
      }
      {
        mime = "application/pdf";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${pkgs.poppler_utils}/bin/pdftotext %pistol-filename%";
      }
      {
        mime = "application/x-x509-ca-cert";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${lib.getExe pkgs.openssl} x509 -text -noout -in %pistol-filename%";
      }
      {
        mime = "application/x-executable";
        command = "sh: ${lib.getExe pkgs.hexyl} -n 64 %pistol-filename%";
      }
      {
        mime = "inode/directory";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${lib.getExe pkgs.eza} --tree --icons --level=1 %pistol-filename%";
      }
      {
        mime = "text/*";
        command = "sh: if (( `stat -c%s   %pistol-filename%` <= 2000000 )); then ${lib.getExe pkgs.bkt} --ttl=30s -- ${lib.getExe pkgs.bat} --style=numbers,grid --paging=never --color=always %pistol-filename% fi";
      }
    ];
  };
}
