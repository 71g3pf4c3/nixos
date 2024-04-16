{ config, pkgs, unstable, lib, inputs, ... }: {
  programs.newsboat = {
    enable = true;
    autoReload = true;
    extraConfig = ''
      color background          color237   color0
      color listnormal          color243   color0
      color listnormal_unread   color132   color0
      color listfocus           color0   color100
      color listfocus_unread    color0   color100
      color info                color248   color0
      color article             color237   color0

      # highlights
      highlight article "^(Feed|Link):.*$" color11 default bold
      highlight article "^(Title|Date|Author):.*$" color11 default bold
      highlight article "https?://[^ ]+" color2 default underline
      highlight article "\\[[0-9]+\\]" color2 default bold
      highlight article "\\[image\\ [0-9]+\\]" color2 default bold
      highlight feedlist "^─.*$" color6 color6 bold

      # unbind keys
      unbind-key ENTER
      unbind-key j
      unbind-key k
      unbind-key J
      unbind-key K

      # bind keys - vim style
      bind-key j down
      bind-key n next-unread
      bind-key p prev-unread
      bind-key k up
      bind-key l open
      bind-key h quit
      bind-key J next-feed
      bind-key K prev-feed
      notify-program "${lib.getExe pkgs.notify-desktop}"
    '';
    urls = [
      { url = "https://www.opennet.ru/opennews/opennews_all_utf.rss"; }
      { url = "https://hnrss.org/newest?count=80&q=NixOs+OR+nixos+OR+nix+OR+nixpkgs+OR+Nix+OR+nix"; }
      { url = "https://hnrss.org/newest?count=80&q=Go+OR+Golang+OR+GoLang"; }
      {
        url = "https://hnrss.org/newest?count=80&q=Kube+OR+Kubernetes+OR+kube+OR+kubernetes+OR+Docker+OR+docker+OR+Podman+OR+podman";
      }
      { url = "https://hnrss.org/newest?count=80&q=Cloud+OR+cloud"; }
      { url = "https://hnrss.org/best?count=80"; }
      { url = "https://rsshub.app/telegram/channel/flant_ru"; }
      { url = "https://rsshub.app/telegram/channel/open_source_friend"; }
      { url = "https://rsshub.app/telegram/channel/black_triangle_tg"; }
      { url = "https://rsshub.app/telegram/channel/bashdays"; }
      { url = "https://rsshub.app/telegram/channel/k8security"; }
      { url = "https://rsshub.app/telegram/channel/SysadminNotes"; }
      { url = "https://rsshub.app/telegram/channel/k8sjust"; }
      { url = "https://rsshub.app/telegram/channel/devopsforlove"; }
      { url = "https://rsshub.app/telegram/channel/tech_b0lt_Genona"; }
      { url = "https://rsshub.app/telegram/channel/sysadmin_tools"; }
      { url = "https://rsshub.app/telegram/channel/ieucariot"; }
      { url = "https://rsshub.app/telegram/channel/kubernetika"; }
      { url = "https://rsshub.app/telegram/channel/owl_tech"; }
      { url = "https://rsshub.app/telegram/channel/tazlog"; }
      { url = "https://rsshub.app/telegram/channel/devopslibrary"; }
      { url = "https://rsshub.app/telegram/channel/count0_digest"; }
      { url = "https://rsshub.app/telegram/channel/linkmeup_podcast"; }
      { url = "https://kubernetes.io/feed.xml"; }
      { url = "https://www.cncf.io/feed/"; }
    ];
  };
}
