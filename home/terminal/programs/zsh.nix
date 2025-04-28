{
  config,
  pkgs,
  unstable,
  lib,
  inputs,
  ...
}:
{
  programs.zsh = {
    enable = true;
    initContent = lib.concatStrings [
      ''
         			zinit wait reset-prompt lucid light-mode for \
         				OMZL::git.zsh \
         				OMZP::kubectl \
         				atload"unalias grv" OMZP::git \
         				OMZL::clipboard.zsh \
         				PZT::modules/{'history','rsync'} \
         				OMZP::sudo \
         				Aloxaf/fzf-tab \
         				zdharma-continuum/fast-syntax-highlighting \
         				olets/zsh-abbr \
         				zsh-users/zsh-completions
         			export PS1="❯ "
         			zinit wait'!' reset-prompt lucid light-mode for \
         				nocd atload"PURE_PROMPT_SYMBOL=" compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh' sindresorhus/pure
         			bindkey '^[[Z' autosuggest-accept
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
         			export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
      ''
    ];
    autosuggestion.enable = true;
    enableCompletion = false;
    completionInit = "autoload -Uz compinit && compinit";
    sessionVariables = {
      PATH = "$PATH:$HOME/.local/bin";
      EDITOR = "nvim";
      VISUAL = "nvim";
      PAGER = "less -FR";
      COLORTERM = "truecolor";
      KUBECONFIG = "${config.home.homeDirectory}/.kube/Main.yml";
      KUBECONFIG_SAVED = "$KUBECONFIG";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      ZSH_AUTOSUGGEST_USE_ASYNC = true;
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=#${config.colorScheme.palette.lightbg3}";
      PASSWORD_STORE_ENABLE_EXTENSIONS = "true pass fzf";
      PASSWORD_STORE_DIR = "$HOME/.password-store";
    };
    envExtra = "skip_global_compinit=1";
    profileExtra = ''
      if [ "$EUID" -ne 0 ]; then
          if [[ ! ( -d /home/$USER/tmp ) ]]; then
              if [[ ! ( -d /tmp/tmp_$USER ) ]]; then
                  mkdir -p /tmp/tmp_$USER/downloads
              fi
              ln -sv /tmp/tmp_$USER /home/$USER/tmp
          fi
      fi

    '';
    shellAliases = {
      "kubectl" = "${lib.getExe pkgs.kubecolor}";
      "psg" = "tr -dc A-Za-z0-9 </dev/urandom | head -c 24; echo";
      "pp" = "pistol";
      "nx" = "nix shell";
      "fe" = "nvim $(fzf)";
      "cat" = "${lib.getExe pkgs.bat}";
      "tree" = "${lib.getExe pkgs.eza} --tree";
      "find" = "${lib.getExe pkgs.fd}";
      "vim" = "nvim";
      "vi" = "nvim";
      "nano" = "nvim";
      "clip" = "${pkgs.wl-clipboard}/bin/wl-copy";
      "cp" = "${lib.getExe pkgs.rsync} -azsP";
      "grep" = "${lib.getExe pkgs.ripgrep}";
      "show" = "${lib.getExe pkgs.chafa}";
      "wifiscan" = "nmcli dev wifi rescan && nmcli dev wifi list";
      "open" = "xdg-open";
      "mount" = "sudo mount -o uid=1000,gid=984";
      "cd" = "z";
      "ci" = "__zoxide_zi";
      "upd" = ''
        ${lib.getExe pkgs.git} -C ~/etc/nixos diff |\
        ${lib.getExe pkgs.bat} --no-pager\
        && ${lib.getExe pkgs.nh} os switch ~/etc/nixos &&\
        ${lib.getExe pkgs.git} -C ~/etc/nixos commit -m "Update from $(${pkgs.coreutils-full}/bin/date)" ~/etc/nixos || ${lib.getExe pkgs.git} -C ~/etc/nixos push ||\
        ${lib.getExe pkgs.notify-desktop} nixos updated -t 1000 && \
        ${lib.getExe pkgs.nh} clean all --keep=4
      '';
    };
    defaultKeymap = "viins";
    autocd = true;
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "zinit.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "zinit";
          rev = "v3.9.0";
          sha256 = "13fn0ni9fkwzy97xc220z433mj0sa7p85srr55wz31kl3w8946yp";
        };
      }
      {
        name = "nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.5.0";
          sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
        };
      }
    ];
  };
}
