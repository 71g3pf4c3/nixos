{
  pkgs,
  lib,
  ...
}:
let
  github = "https://github.com/";
  rsshub = "https://rsshub.app/";
in
{
  programs.newsboat = {
    enable = true;
    autoReload = true;
    extraConfig = ''
      text-width 0
      article-sort-order desc
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
      # HackerNews
      { url = "https://hnrss.org/newest?count=80&q=NixOs+OR+nixos+OR+nix+OR+nixpkgs+OR+Nix+OR+nix"; }
      { url = "https://hnrss.org/newest?count=80&q=Go+OR+Golang+OR+GoLang"; }
      {
        url = "https://hnrss.org/newest?count=80&q=Kube+OR+Kubernetes+OR+kube+OR+kubernetes+OR+Docker+OR+docker+OR+Podman+OR+podman";
      }
      { url = "https://hnrss.org/newest?count=80&q=Cloud+OR+cloud"; }
      { url = "https://hnrss.org/best?count=80"; }

      # Tech oss news
      { url = "https://www.opennet.ru/opennews/opennews_all_utf.rss"; }
      { url = "https://kubernetes.io/feed.xml"; }
      { url = "https://www.cncf.io/feed/"; }
      { url = "https://www.phoronix.com/rss.php"; }
      # Telegram channels
      { url = rsshub+"telegram/channel" + "flant_ru"; }
      { url = rsshub+"telegram/channel" + "open_source_friend"; }
      { url = rsshub+"telegram/channel" + "black_triangle_tg"; }
      { url = rsshub+"telegram/channel" + "bashdays"; }
      { url = rsshub+"telegram/channel" + "k8security"; }
      { url = rsshub+"telegram/channel" + "SysadminNotes"; }
      { url = rsshub+"telegram/channel" + "k8sjust"; }
      { url = rsshub+"telegram/channel" + "devopsforlove"; }
      { url = rsshub+"telegram/channel" + "tech_b0lt_Genona"; }
      { url = rsshub+"telegram/channel" + "sysadmin_tools"; }
      { url = rsshub+"telegram/channel" + "ieucariot"; }
      { url = rsshub+"telegram/channel" + "kubernetika"; }
      { url = rsshub+"telegram/channel" + "owl_tech"; }
      { url = rsshub+"telegram/channel" + "tazlog"; }
      { url = rsshub+"telegram/channel" + "devopslibrary"; }
      { url = rsshub+"telegram/channel" + "count0_digest"; }
      { url = rsshub+"telegram/channel" + "linkmeup_podcast"; }
      { url = "telegram/channel/KubernetesArchitect"; }
      # Git releases
      { url = github+"cluster-api/releases.atom"; }
      { url = github+"kubernetes/kubernetes/releases.atom"; }
    ];
  };
}
