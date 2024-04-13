{ config, pkgs, unstable, lib, inputs, ... }: {
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
      # only show status bar if there is more then one window
      set -g status on
      set-option -g status-interval 5
      set-option -g automatic-rename on
      set-option -g automatic-rename-format '#{b:pane_current_path}'
      set -g status-fg "#${config.colorScheme.palette.base06}"
      set -g status-bg "#${config.colorScheme.palette.base02}"
      set-option -g status-left "#[fg=#${config.colorScheme.palette.base04}, bg=#${config.colorScheme.palette.base01}, bold] #{session_name} "
      set-window-option -g window-status-current-format "#[bg=#${config.colorScheme.palette.base00}, fg=#${config.colorScheme.palette.base07},bold,italics] #[noitalics]#[italics]#W#{?window_zoomed_flag,*Z,} "
      set-window-option -g window-status-format "#[noitalics,bg=#${config.colorScheme.palette.base02},fg=#${config.colorScheme.palette.base00}] #[noitalics]#W "
      set-window-option -g window-status-separator ""
      set-option -g window-style 'bg=default'
      set-option -g popup-border-lines heavy
      set-option -g pane-border-lines heavy
      set-option -g popup-border-style 'fg=#${config.colorScheme.palette.base0B},bold'
      set-option -g pane-border-style 'fg=#${config.colorScheme.palette.base01}'
      set-option -g pane-active-border-style 'fg=#${config.colorScheme.palette.base0B}'
      set -g pane-border-status off
      set -s copy-command '${pkgs.wl-clipboard}/bin/wl-copy'
      set -g pane-border-format "#[bold,fg=#${config.colorScheme.palette.base00}, bg=#${config.colorScheme.palette.base0B} ] #{pane_index}:#{pane_title} #[default]"
      set-hook -g window-layout-changed 'set-window -F pane-border-status "#{?#{==:#{window_panes},1},off,bottom}"'
      set-hook -g after-new-window 'set-option -g -F status "#{?#{==:#{session_windows},1},off,on}"'
      set-hook -g after-kill-pane 'set-option -g -F status "#{?#{==:#{session_windows},1},off,on}"'

      bind-key -n M-e new-window
      bind-key -n M-t next-window
      bind-key -n M-T previous-window
      bind-key -n M-c new-session -c "#{pane_current_path}"
      bind-key -n M-\\ split-window -h -c "#{pane_current_path}"
      bind-key -n M-- split-window -v -c "#{pane_current_path}"
      bind-key -n M-x kill-pane
      bind-key -n M-h select-pane -L
      bind-key -n M-j select-pane -D
      bind-key -n M-k select-pane -U
      bind-key -n M-l select-pane -R
      bind-key -n M-b if-shell -F '#{==:#{session_name},scratch}' {
        kill-session -t scratch
      } {
        display-popup -h 70% -w 70% -E -d "#{pane_current_path}" -T "#{pane_current_path}" tmux new -A -s scratch -n "scratch"
      }
      bind-key -n M-g display-popup -h 80% -w 80% -E -d "#{pane_current_path}" -T "#{pane_current_path}" tmux new -s lazygit -n lazygit "${lib.getExe pkgs.lazygit}"
      bind-key -n M-y if-shell -F '#{==:#{session_name},kubectx}' {
        kill-session -t kubectx
      } {
        display-popup -h 40% -w 40% -E -d "#{pane_current_path}" -T "#{pane_current_path}" tmux new -s kubectx -n kubectx "tmux set status && ${pkgs.kubectx}/bin/kubectx"
      }
      bind-key -n M-n if-shell -F '#{==:#{session_name},news}' {
        detach-client
      } {
        display-popup -h 90% -w 80% -E -d "#{pane_current_path}" -T "#{pane_current_path}" tmux new -A -s news -n news "newsboat"
      }
      bind-key -n M-u if-shell -F '#{==:#{session_name},k9s}' {
        detach-client
      } {
        display-popup -h 80% -w 80% -E -d "#{pane_current_path}" -T "#{pane_current_path}" tmux new -A -s k9s -n k9s "tmux set status && k9s --kubeconfig /home/t1g3pf4c3/.kube/Main.yml"
      }
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
        extraConfig = "	set -g @scroll-down-exit-copy-mode 'off'\n	set -g @emulate-scroll-for-no-mouse-alternate-buffer 'on'\n";
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
          set -g @ssh-split-v-key '-n M-_'
          set -g @ssh-split-h-key '-n M-|'
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
        extraConfig = "\n				set -g @session-wizard 'h'\n				set -g @session-wizard-width 40\n			";
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
        extraConfig = "\n				set -g @mode_indicator_empty_mode_style 'bold,bg=#${config.colorScheme.palette.base03},fg=#${config.colorScheme.palette.base00}'\n				set -g @mode_indicator_prefix_mode_style 'bold,bg=#${config.colorScheme.palette.base0D},fg=#${config.colorScheme.palette.base00}'\n				set -g @mode_indicator_copy_mode_style 'bold,bg=#${config.colorScheme.palette.base08},fg=#${config.colorScheme.palette.base00}'\n				set -g @mode_indicator_sync_mode_style 'bold,bg=#${config.colorScheme.palette.base0F},fg=#${config.colorScheme.palette.base00}'\n				set-option -g status-right \"#[bold,fg=#${config.colorScheme.palette.base00}, bg=#${config.colorScheme.palette.base0B} ] #{host} #{tmux_mode_indicator}\" \n			";
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
        extraConfig = "	set -g @suspend_key 'F12'\n						set -g @suspend_suspended_options \" \\\n						@mode_indicator_custom_prompt:: SUSP\"\n					";
      }
    ];
  };
}
