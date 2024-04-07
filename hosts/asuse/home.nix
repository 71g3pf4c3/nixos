{ config, pkgs, lib, inputs, ... }:
let
  font = "Comic Code Ligatures";
  terminal = "${lib.getExe pkgs.tym}";
  colorscheme = {
    light = {
      name = "gruvbox-light";
      bg = "#ebdbb2";
      red = "#cc241d";
      green = "#98971a";
      yellow = "#d79921";
      blue = "#458588";
      purple = "#b16286";
      aqua = "#689d6a";
      gray = "#7c6f64";
      redalt = "#9d0006";
      greenalt = "#79740e";
      yellowalt = "#b57614";
      bluealt = "#076678";
      magentaalt = "#8f3f71";
      aquaalt = "#427b58";
      fg = "#3c3836";
      grayalt = "#928374";
      bg0_h = "#f9f5d7";
      bg0 = "#fbf1c7";
      bg1 = "#ebdbb2";
      bg2 = "#d5c4a1";
      bg3 = "#bdae93";
      bg4 = "#a89984";
      orange = "#d65d0e";
      bg0_s = "#f2e5bc";
      fg0 = "#282828";
      fg1 = "#3c3836";
      fg2 = "#504945";
      fg3 = "#665c54";
      fg4 = "#7c6f64";
      orangealt = "#af3a03";
    };
    dark = {
      name = "gruvbox-dark";
      bg = "#282828";
      red = "#cc241d";
      green = "#98971a";
      yellow = "#d79921";
      blue = "#458588";
      magenta = "#b16286";
      aqua = "#689d6a";
      gray = "#a89984";
      redalt = "#fb4934";
      greenalt = "#b8bb26";
      yellowalt = "#fabd2f";
      bluealt = "#83a598";
      magentaalt = "#d3869b";
      aquaalt = "#8ec07c";
      fg = "#ebdbb2";
      grayalt = "#928374";
      bg0_h = "#1d2021";
      bg0 = "#282828";
      bg1 = "#3c3836";
      bg2 = "#504945";
      bg3 = "#665c54";
      bg4 = "#7c6f64";
      orange = "#d65d0e";
      bg0_s = "#32302f";
      fg0 = "#fbf1c7";
      fg1 = "#ebdbb2";
      fg2 = "#d5c4a1";
      fg3 = "#bdae93";
      fg4 = "#a89984";
      orangealt = "#fe8019";
    };
    dim = {
      fg = "#928374";
      red = "#fb4934";
      green = "#b8bb26";
      yellow = "#fabd2f";
      blue = "#83a598";
      purple = "#d3869b";
      aqua = "#83c07c";
      bg = "#ebdbb2";
    };
  };
in {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ../../config/nixvim.nix
    # inputs.stylix.homeManagerModules.stylix
  ];
  home.username = "t1g3pf4c3";
  home.homeDirectory = "/home/t1g3pf4c3";
  home.stateVersion = "23.11";
  home.packages = with pkgs; [
    tym
    ncdu
    telegram-desktop
    kubectl
    fd
    tmux-xpanes
    wtf
    playerctl
    translate-shell
    webcord-vencord
    zoom-us
    popeye
    dig
    nodePackages.webtorrent-cli
    sxiv
    qbittorrent
    libreoffice
    drawio
    k8sgpt
    kube-capacity
    kubectl-tree
    kubectl-node-shell
    kubernetes-helm
    cargo
    nodejs
    buku
    bukubrow
    wdisplays
    gcc_multi
    xdragon
    wineWowPackages.waylandFull
    unzip
    python3
    pavucontrol
    restic
    stylua
    nixfmt
    shellcheck
    shellharden
    yq-go
    codespell
    gptcommit
    aichat
  ];
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
    size = 22;
  };
  services = {
    kdeconnect = {
      enable = true;
      indicator = true;
    };
    network-manager-applet.enable = true;
    cliphist = {
      enable = true;
      systemdTarget = "sway-session.target";
    };
  };
  xdg.configFile."tym" = {
    source = ../../config/tym;
    recursive = true;
  };
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    initExtra = lib.concatStrings [''
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
    ''];
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
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=${colorscheme.light.bg2}";
      PASSWORD_STORE_ENABLE_EXTENSIONS = "true pass fzf";
      PASSWORD_STORE_DIR = "$HOME/.password-store";
    };
    envExtra = "skip_global_compinit=1";
    shellAliases = {
      "kubectl" = "${lib.getExe pkgs.kubecolor}";
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
      "docker" = "${lib.getExe pkgs.podman}";
      "show" = "${lib.getExe pkgs.chafa}";
      "wifiscan" = "nmcli dev wifi rescan && nmcli dev wifi list";
      "open" = "xdg-open";
      "mount" = "sudo mount -o uid=1000,gid=984";
      "cd" = "z";
      "ci" = "zi";
      "upd" = ''
        ${lib.getExe pkgs.git} diff |\
        ${lib.getExe pkgs.bat} --no-pager\
        && sudo nixos-rebuild switch -j 16  --flake ~/nixos/# &&\
        ${lib.getExe pkgs.git} commit -a && ${lib.getExe pkgs.git} push &&\
        ${lib.getExe pkgs.notify-desktop} nixos updated -t 1000
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
  programs.fzf = {
    enable = true;
    defaultCommand =
      "${pkgs.fd}/bin/fd --strip-cwd-prefix --hidden --follow --exclude .git";
    fileWidgetOptions = [
      "--bind=alt-k:up,alt-j:down"
      "--preview '${lib.getExe pkgs.pistol} {}'"
    ];
  };
  programs.bat = {
    enable = true;
    config = {
      theme = colorscheme.light.name;
      map-syntax = [ "*.jenkinsfile:Groovy" "*Jenkinsfile:Groovy" ];
      pager = "${lib.getExe pkgs.less} -FR";
    };
  };
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    mouse = true;
    historyLimit = 20000;
    newSession = false;
    escapeTime = 0;
    aggressiveResize = true;
    keyMode = "vi";
    clock24 = true;
    shell = "${lib.getExe pkgs.zsh}";
    extraConfig = ''
      set -g set-titles on
      set -g status-keys vi
      set -g set-titles-string '#S:#I.#P #W'
      setw -g automatic-rename
      bind x kill-pane
      bind & kill-window
      bind v copy-mode
      bind V choose-buffer
      bind S setw synchronize-panes
      bind C-V pasteb
      bind ";" next-layout
      bind -r  r source-file ${config.home.homeDirectory}/.config/tmux/tmux.conf
      bind < swap-pane -D
      bind > swap-pane -U
      # pane resizing
      bind -r H resize-pane -L 2
      bind -r J resize-pane -D 2
      bind -r K resize-pane -U 2
      bind -r L resize-pane -R 2
      bind s swap-window
      bind j join-pane
      bind 'C-C' new-session
      bind -r \\ split-window -h -c "#{pane_current_path}"
      bind -r - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi V send -X select-line
      bind -T copy-mode-vi y send -X copy-pipe '${pkgs.wl-clipboard}/bin/wl-copy'
      bind -T copy-mode-vi 'C-h' select-pane -L
      bind -T copy-mode-vi 'C-j' select-pane -D
      bind -T copy-mode-vi 'C-k' select-pane -U
      bind -T copy-mode-vi 'C-l' select-pane -R
      bind -T copy-mode-vi '^\' select-pane -l
      bind -T copy-mode-vi 'C-Space' select-pane -t:.+
      set -ga terminal-overrides ",*256col*:Tc"
      set-option -g renumber-windows on
      set-option -g status-position top
      set-option -g status-justify left
      bind-key q set status
      bind-key n next-window
      bind-key b if-shell -F '#{==:#{session_name},scratch}' {
        kill-session -t scratch
      } {
        display-popup -h 70% -w 70% -E -d "#{pane_current_path}" -T "#{pane_current_path}" tmux new -A -s scratch -n "scratch"
      }
      bind-key g display-popup -h 80% -w 80% -E -d "#{pane_current_path}" -T "#{pane_current_path}" tmux new -s lazygit -n lazygit "${
        lib.getExe pkgs.lazygit
      }"
      bind-key y if-shell -F '#{==:#{session_name},kubectx}' {
        kill-session -t kubectx
      } {
        display-popup -h 40% -w 40% -E -d "#{pane_current_path}" -T "#{pane_current_path}" tmux new -s kubectx -n kubectx "tmux set status && ${pkgs.kubectx}/bin/kubectx"
      }
      bind-key s if-shell -F '#{==:#{session_name},news}' {
        detach-client
      } {
        display-popup -h 90% -w 80% -E -d "#{pane_current_path}" -T "#{pane_current_path}" tmux new -A -s news -n news "newsboat"
      }
      bind-key m if-shell -F '#{==:#{session_name},k9s}' { detach-client } { display-popup -h 80% -w 80% -E -d "#{pane_current_path}" -T "#{pane_current_path}" tmux new -A -s k9s -n k9s "tmux set status && k9s --kubeconfig /home/t1g3pf4c3/.kube/Main.yml" }
      bind-key u display-popup -h 50% -w 50% -d "#{pane_current_path}" -T "#{pane_current_path}" tmux new -s update -n update "upd "
      # only show status bar if there is more then one window
      set -g status on
      set-option -g status-interval 5
      set-option -g automatic-rename on
      set-option -g automatic-rename-format '#{b:pane_current_path}'
      set-option -g automatic-rename-format "#{?#{==:#{b:pane_current_path},t1g3pf4c3},#{pane_current_command},#{b:pane_current_path}}"
      set -g status-fg "${colorscheme.light.grayalt}"
      set -g status-bg "${colorscheme.light.bg3}"
      set-option -g status-left "#[fg=${colorscheme.light.gray}, bg=${colorscheme.light.bg2}, bold] #{session_name} "
      set-window-option -g window-status-current-format "#[bg=${colorscheme.light.bg}, fg=${colorscheme.light.fg},bold,italics] #[noitalics]#[italics]#W#{?window_zoomed_flag,*Z,} "
      set-window-option -g window-status-format "#[noitalics,bg=${colorscheme.light.bg3},fg=${colorscheme.light.bg}] #[noitalics]#W "
      set-window-option -g window-status-separator ""
      set-option -g window-style 'bg=default'
      set-option -g popup-border-lines heavy
      set-option -g pane-border-lines heavy
      set-option -g popup-border-style 'fg=${colorscheme.light.green},bold'
      set-option -g pane-border-style 'fg=${colorscheme.light.bg2}'
      set-option -g pane-active-border-style 'fg=${colorscheme.light.green}'
      set -g pane-border-status off
      set -s copy-command '${pkgs.wl-clipboard}/bin/wl-copy'
      set -g pane-border-format "#[bold,fg=${colorscheme.light.bg}, bg=${colorscheme.light.green} ] #{pane_index}:#{pane_title} #[default]"
      set-hook -g window-layout-changed 'set-window -F pane-border-status "#{?#{==:#{window_panes},1},off,bottom}"'
      set-hook -g after-new-window 'set-option -g -F status "#{?#{==:#{session_windows},1},off,on}"'
      set-hook -g after-kill-pane 'set-option -g -F status "#{?#{==:#{session_windows},1},off,on}"'
    '';
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.extrakto;
        extraConfig = ''
          set -g @extrakto_clip_tool	'${pkgs.wl-clipboard}/bin/wl-copy'
        '';
      }
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.logging
      {
        plugin = tmuxPlugins.better-mouse-mode;
        extraConfig =
          "	set -g @scroll-down-exit-copy-mode 'off'\n	set -g @emulate-scroll-for-no-mouse-alternate-buffer 'on'\n";
      }
      {
        plugin = tmuxPlugins.mkTmuxPlugin {
          pluginName = "tmux-ssh-split";
          rtpFilePath = "ssh-split.tmux";
          version = "bccb77f";
          src = pkgs.fetchFromGitHub {
            owner = "pschmitt";
            repo = "tmux-ssh-split";
            rev = "bccb77fa45077763967978a32dc401767f170248";
            sha256 = "sha256-Z16laz2Xeyg4/eCbS5qqXxLB6xpADvHWKWlfJqLYO/k=";
          };
        };
        extraConfig = ''
          set -g @ssh-split-v-key '_'
          set -g @ssh-split-h-key |
        '';
      }
      {
        plugin = tmuxPlugins.mkTmuxPlugin {
          pluginName = "tmux-session-wizard";
          version = "e13c4c4";
          rtpFilePath = "session-wizard.tmux";
          src = pkgs.fetchFromGitHub {
            owner = "27medkamal";
            repo = "tmux-session-wizard";
            rev = "e13c4c47c72039b3bcf2706ecf428b099c00b215";
            sha256 = "sha256-Nz1vfl4owkQG3l2laao9Z6IW1w0nlhYuwHTuag1ajwM=";
          };
        };
        extraConfig =
          "\n				set -g @session-wizard 'h'\n				set -g @session-wizard-width 40\n			";
      }
      {
        plugin = tmuxPlugins.mkTmuxPlugin {
          pluginName = "mode-indicator";
          version = "7027903";
          src = pkgs.fetchFromGitHub {
            owner = "MunifTanjim";
            repo = "tmux-mode-indicator";
            rev = "7027903adca37c54cb8f5fa99fc113b11c23c2c4";
            sha256 = "1zbci8kmkr4kis2zv0lgzi04knbjzx6zsxyxwrpc46z8hagyq328";
          };
        };
        extraConfig =
          "\n				set -g @mode_indicator_empty_mode_style 'bold,bg=${colorscheme.dark.bg4},fg=${colorscheme.dark.fg}'\n				set -g @mode_indicator_prefix_mode_style 'bold,bg=${colorscheme.dark.blue},fg=${colorscheme.dark.fg}'\n				set -g @mode_indicator_copy_mode_style 'bold,bg=${colorscheme.dark.red},fg=${colorscheme.dark.fg}'\n				set -g @mode_indicator_sync_mode_style 'bold,bg=${colorscheme.dark.orange},fg=${colorscheme.dark.fg}'\n				set-option -g status-right \"#[bold,fg=${colorscheme.dark.fg}, bg=${colorscheme.dark.green} ] #{host} #{tmux_mode_indicator}\" \n			";
      }
      {
        plugin = tmuxPlugins.mkTmuxPlugin {
          pluginName = "cowboy";
          version = "75702b6";
          src = pkgs.fetchFromGitHub {
            owner = "tmux-plugins";
            repo = "tmux-cowboy";
            rev = "75702b6d0a866769dd14f3896e9d19f7e0acd4f2";
            sha256 = "16wqwfaqy7nhiy1ijkng1x4baqq7s9if0m3ffcrnakza69s6r4r8";
          };
        };
      }
      {
        plugin = tmuxPlugins.mkTmuxPlugin {
          pluginName = "suspend";
          version = "1a2f806";
          src = pkgs.fetchFromGitHub {
            owner = "MunifTanjim";
            repo = "tmux-suspend";
            rev = "1a2f806666e0bfed37535372279fa00d27d50d14";
            sha256 = "0j7vjrwc7gniwkv1076q3wc8ccwj42zph5wdmsm9ibz6029wlmzv";
          };
        };
        extraConfig =
          "	set -g @suspend_key 'F12'\n						set -g @suspend_suspended_options \" \\\n						@mode_indicator_custom_prompt:: SUSP\"\n					";
      }
    ];
  };
  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
      recolor-lightcolor = colorscheme.dark.fg;
      recolor-darkcolor = colorscheme.dark.bg;
      default-bg = colorscheme.dark.bg;
      highlight-color = colorscheme.dark.orange;
      highlight-active-color = colorscheme.dark.magenta;
      inputbar-fg = colorscheme.dark.fg;
      inputbar-bg = colorscheme.dark.bg1;
      statusbar-fg = colorscheme.dark.fg;
      statusbar-bg = colorscheme.dark.bg1;
      index-fg = colorscheme.dark.fg;
      index-bg = colorscheme.dark.bg1;
      index-active-fg = colorscheme.dark.fg0;
      index-active-bg = colorscheme.dark.bg4;
      notification-bg = colorscheme.dark.fg0;
      notification-fg = colorscheme.dark.bg4;
      adjust-open = "width";
      recolor = true;
    };
  };
  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.password-store";
      PASSWORD_STORE_CLIP_TIME = "60";
    };
  };
  programs.rofi = {
    # plugins = with pkgs; [ rofi-emoji rofi-calc ];
    package = pkgs.rofi-wayland;
    enable = true;
    theme = colorscheme.light.name;
    terminal = terminal;
    pass = {
      enable = true;
      stores = [ "${config.home.homeDirectory}/.password-store" ];
      package = pkgs.rofi-pass-wayland;
      extraConfig = ''
        delay=0.001
        wait=0.001
        type_delay=1
        auto_enter='true'
        default_autotype='pass'
        clip_clear=3
        default_do='typePass'
      '';
    };
    extraConfig = {
      kb-primary-paste = "Control+V,Shift+Insert";
      kb-secondary-paste = "Control+v,Insert";
    };
  };
  programs.pistol = {
    enable = true;
    associations = [
      {
        fpath = ".*.md$";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${
            lib.getExe pkgs.bat
          } --paging=never --color=always %pistol-filename%";
      }
      {
        fpath = ".*.pem$";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${
            lib.getExe pkgs.openssl
          } x509 -text -noout -in %pistol-filename% || bat %pistol-filename%";
      }
      {
        fpath = ".*.crt$";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${
            lib.getExe pkgs.openssl
          } x509 -text -noout -in %pistol-filename% || bat %pistol-filename%";
      }
      {
        fpath = ".*.csr$";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${
            lib.getExe pkgs.openssl
          } x509 -text -noout -in %pistol-filename% || bat %pistol-filename%";
      }
      {
        fpath = ".*.md$";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${
            lib.getExe pkgs.bat
          } --paging=never --color=always %pistol-filename% ";
      }
      {
        fpath = ".*.ini$";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${
            lib.getExe pkgs.bat
          } --paging=never --color=always %pistol-filename% ";
      }
      {
        fpath = ".*.norg$";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${
            lib.getExe pkgs.bat
          } --paging=never --color=always %pistol-filename% ";
      }
      {
        fpath = ".*.log$";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${
            lib.getExe pkgs.lnav
          } %pistol-filename%";
      }
      {
        fpath = ".*.docx";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${
            lib.getExe pkgs.python311Packages.docx2txt
          } %pistol-filename%";
      }
      {
        fpath = ".*.odt";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${
            lib.getExe pkgs.odt2txt
          } %pistol-filename%";
      }
      {
        fpath = ".*.zip";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${
            lib.getExe pkgs.unzip
          } -l %pistol-filename%";
      }
      {
        fpath = ".*.tar.*";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${
            lib.getExe pkgs.gnutar
          } -tavf %pistol-filename%";
      }
      {
        fpath = ".*.torrent";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${
            lib.getExe pkgs.nodePackages.webtorrent-cli
          } info %pistol-filename%";
      }
      {
        mime = "image/*";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${
            lib.getExe pkgs.chafa
          } %pistol-filename%";
      }
      {
        mime = "application/*";
        command = "${lib.getExe pkgs.eza} %pistol-filename%";
      }
      {
        mime = "application/json";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${
            lib.getExe pkgs.jq
          } %pistol-filename%";
      }
      {
        mime = "application/pdf";
        command = "sh: ${
            lib.getExe pkgs.bkt
          } --ttl=30s -- ${pkgs.poppler_utils}/bin/pdftotext %pistol-filename%";
      }
      {
        mime = "application/x-x509-ca-cert";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${
            lib.getExe pkgs.openssl
          } x509 -text -noout -in %pistol-filename%";
      }
      {
        mime = "application/x-executable";
        command = "sh: ${lib.getExe pkgs.hexyl} -n 64 %pistol-filename%";
      }
      {
        mime = "inode/directory";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${
            lib.getExe pkgs.eza
          } --tree --icons --level=1 %pistol-filename%";
      }
      {
        mime = "text/*";
        command = "sh: ${lib.getExe pkgs.bkt} --ttl=30s -- ${
            lib.getExe pkgs.bat
          } --paging=never --color=always %pistol-filename%";
      }
    ];
  };
  programs.lf = {
    enable = true;
    settings = {
      ratios = "1:1:2";
      ignorecase = true;
      hidden = false;
      info = "size:time";
    };
    previewer.source = "${lib.getExe pkgs.pistol}";
    keybindings = {
      D = "delete";
      gh = "cd ${config.home.homeDirectory}";
      gr = "cd /";
      gp = "cd ${config.home.homeDirectory}/projects";
      o = "dragdrop";
      R = "bulk-rename";
      E = "edit";
      C = "copy-content";
      K = "kubeapply";
      f = "copy-path";
      T = "mkfile";
      F = "$xdg-open $(${lib.getExe pkgs.fzf})";
      M = "push $mkdir<space>";
      Z = "zi";
    };
    commands = {
      open = "cmd open $xdg-open $fx";
      on-cd = ''
        &{{
          zoxide add "$PWD"
        }}
      '';
      zi = "	\${{\n			__zoxide_zi\n	}}\n";
      kubeapply = "	\${{\n			kubectl apply -f  \"$fx\"\n	}}\n";
      copy-path =
        "	\${{\n			printf \"$fx\" | ${pkgs.wl-clipboard}/bin/wl-copy \n	}}\n";
      dragdrop =
        "	\${{\n			printf '%s\\n' \"$fx\" | dragon -a -x -T -I \n	}}\n";
      copy-content = ''
          ''${{
        cat $fx | ${pkgs.wl-clipboard}/bin/wl-copy
          	}}
      '';
      bulk-rename = ''
        ''${{
        	old="$(mktemp)"
        	new="$(mktemp)"
        	[ -n "$fs" ] || fs="$(ls)"
        	printf '%s' "$fs" > "$old"
        	printf '%s' "$fs" > "$new"
        	$EDITOR "$new"
        	[ "$(wc -l "$new")" -ne "$(wc -l "$old")" ] && exit
        	paste "$old" "$new" | while IFS=$(printf "\t") read -r src dst; do
        			if [ "$src" = "$dst" ] || [ -e "$dst" ]; then
        					continue
        			fi
        			mv -- "$src" "$dst"
        	done
        	rm -- "$old" "$new"
        	lf -remote "send $id unselect"
        	}}
      '';
      edit = "	\${{\n	nvim $fs\n	}}\n";
      unarchive = ''
        ''${{
        	case "$f" in
        			*.zip) ${lib.getExe pkgs.unzip} "$f" ;;
        			*.tar*) ${lib.getExe pkgs.gnutar} -xvaf "$f" ;;
        			*) echo "Unsupported format" ;;
        	esac
        	}}
      '';
      archive = "	\${{\n		tar -cavf $f.tar.zstd $f\n	}}\n";
      mkfile = ''
        ''${{
        	printf "File Name: "
        	read and
        	$EDITOR $and
        	}}
      '';
    };
  };
  programs.eza = { enable = true; };
  programs.jq.enable = true;
  programs.lazygit.enable = true;
  programs.k9s = {
    enable = true;
    settings = {
      k9s = {
        refreshRate = 3;
        liveViewAutoRefresh = true;
        disablePodCounting = false;
        ui = {
          skin = "gruvbox-light";
          enableMouse = false;
          headless = true;
          logoless = true;
          crumbsless = true;
          reactive = true;
          noIcons = true;
        };
        logger = {
          tail = 400;
          buffer = 5000;
          sinceSeconds = -200;
          fullScreen = true;
          textWrap = true;
          showTime = true;
        };
      };
    };
  };
  home.file.".config/k9s/skins" = {
    source = ../../config/k9s/skins;
    recursive = true;
  };
  programs.mpv = {
    enable = true;
    config = {
      ytdl-format =
        "bestvideo[height<=?720][fps<=?30][vcodec!=?h264]+worstaudio/[acodec=opus][abr<=?70]";
      geometry = "40%+90%+10%";
      script-opts = "ytdl_hook-ytdl_path=${lib.getExe pkgs.yt-dlp}";
    };
  };
  programs.watson.enable = true;
  programs.htop.enable = true;
  programs.git = {
    enable = true;
    includes = [
      {
        contents = {
          user = {
            email = "mkungurov@runity.ru";
            name = "Кунгуров Макар Евгеньевич";
          };
        };
      }
      {
        contents = {
          user = {
            email = "71g3pf4c3@gmail.com";
            name = "71g3pf4c3";
          };
        };
      }
    ];
    delta = {
      enable = true;
      options = {
        side-by-side = true;
        line-numbers = true;
        syntax-theme = "${colorscheme.light.name}";
      };
    };
  };
  programs.gh.enable = true;
  programs.chromium = {
    enable = true;
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
  xdg.mime.enable = true;
  xdg.mimeApps = { enable = true; };

  programs.zoxide.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv = { enable = true; };
  };
  # programs.obs-studio = {
  #   enable = true;
  #   plugins = with pkgs; [ obs-studio-plugins.wlrobs ];
  # };
  programs.atuin = {
    enable = true;
    settings = {
      keymap_mode = "vim-normal";
      enter_accept = true;
      # inline_height = 30;
    };
  };

  programs.ripgrep.enable = true;

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 34560000;
    maxCacheTtl = 34560000;
    enableSshSupport = true;
    pinentryPackage = lib.mkForce pkgs.pinentry-qt;
  };

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
      {
        url =
          "https://hnrss.org/newest?count=80&q=NixOs+OR+nixos+OR+nix+OR+nixpkgs+OR+Nix+OR+nix";
      }
      { url = "https://hnrss.org/newest?count=80&q=Go+OR+Golang+OR+GoLang"; }
      {
        url =
          "https://hnrss.org/newest?count=80&q=Kube+OR+Kubernetes+OR+kube+OR+kubernetes+OR+Docker+OR+docker+OR+Podman+OR+podman";
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
      { url = "https://rsshub.app/telegram/channel/owl_tech"; }
      { url = "https://rsshub.app/telegram/channel/tazlog"; }
      { url = "https://rsshub.app/telegram/channel/devopslibrary"; }
      { url = "https://rsshub.app/telegram/channel/count0_digest"; }
      { url = "https://rsshub.app/telegram/channel/linkmeup_podcast"; }
      { url = "https://kubernetes.io/feed.xml"; }
      { url = "https://www.cncf.io/feed/"; }
    ];
  };
  # programs.foot = {
  #   enable = true;
  #   server.enable = true;
  #   settings = {
  #     main = {
  #       term = "xterm-256color";
  #       font = "${font}:size=14";
  #       dpi-aware = "yes";
  #       shell = "${lib.getExe pkgs.zsh}";
  #     };
  #     mouse = {hide-when-typing = "yes";};
  #     text-bindings = {
  #     };
  #   };
  # };
}
