{ pkgs, lib, ... }:
let
  github = "https://github.com/";
  rsshubTg = "https://rsshub.app/telegram/channel/";
in
{
  programs.newsboat = {
    enable = true;
    autoReload = true;
    extraConfig = ''
       article-sort-order desc
       download-full-page yes
       color background          color237   color0
       color listnormal          color243   color0
       color listnormal_unread   color132   color0
       color listfocus           color0   color100
       color listfocus_unread    color0   color100
       color info                color248   color0
       color article             color237   color0

       # highlights
      # highlight article "^(Feed|Link):.*$" color11 default bold
      # highlight article "^(Title|Date|Author):.*$" color11 default bold
      # highlight article "https?://[^ ]+" color2 default underline
      # highlight article "\\[[0-9]+\\]" color2 default bold
      # highlight article "\\[image\\ [0-9]+\\]" color2 default bold
      # highlight feedlist "^─.*$" color6 color6 bold

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
      { url = rsshubTg + "flant_ru"; }
      { url = rsshubTg + "open_source_friend"; }
      { url = rsshubTg + "black_triangle_tg"; }
      { url = rsshubTg + "bashdays"; }
      { url = rsshubTg + "k8security"; }
      { url = rsshubTg + "SysadminNotes"; }
      { url = rsshubTg + "k8sjust"; }
      { url = rsshubTg + "devopsforlove"; }
      { url = rsshubTg + "tech_b0lt_Genona"; }
      { url = rsshubTg + "sysadmin_tools"; }
      { url = rsshubTg + "ieucariot"; }
      { url = rsshubTg + "kubernetika"; }
      { url = rsshubTg + "owl_tech"; }
      { url = rsshubTg + "tazlog"; }
      { url = rsshubTg + "devopslibrary"; }
      { url = rsshubTg + "count0_digest"; }
      { url = rsshubTg + "linkmeup_podcast"; }
      { url = rsshubTg + "KubernetesArchitect"; }
      # Git releases
      { url = github + "kubernetes-sigs/cluster-api/releases.atom"; }
      { url = github + "kubernetes/kubernetes/releases.atom"; }
      { url = github + "cloudnative-pg/cloudnative-pg/releases.atom"; }
      { url = github + "kubernetes-sigs/kind/releases.atom"; }
      { url = github + "awesome-ssh/commits/master.atom"; }
      { url = github + "rothgar/awesome-tmux/commits/master.atom"; }
      { url = github + "nix-community/awesome-nix/commits/master.atom"; }
      { url = github + "ramitsurana/awesome-kubernetes/commits/master.atom"; }
    ];
  };
}
