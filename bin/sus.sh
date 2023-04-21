echo starting
TMUXPATH="$HOME/.config/tmux.conf"
if [[ $1 = "ssh" && -f $TMUXPATH ]]; then
	SUBSTCOLOR="$(printf '%s' "$2" | md5sum | cut -c1-6)"
	TMUXCONF="/tmp/tmux.tmp.conf.$SUBSTCOLOR"
	SUBSTBG="#f2e5bc"
	if command -v pastel &>/dev/null; then
		SUBSTBG="$(pastel lighten 0.4 "$SUBSTCOLOR" | pastel mix f2e5bc | pastel format hex)"
	fi
	echo "preparing .tmux.conf"
	cp -L "$TMUXPATH" "$TMUXCONF" && chmod 666 "$TMUXCONF"
	cat <<EOF >>"$TMUXCONF"
set-option -g status-right '#[bold,fg=#ebdbb2, bg=#$SUBSTCOLOR] #{host} #{tmux_mode_indicator}'
#set-option -g pane-border-lines heavy
set-option -g pane-active-border-style 'fg=#$SUBSTCOLOR, bg=#$SUBSTCOLOR'
set-option -g pane-border-style 'fg=#ebdbb2, bg=#ebdbb2'
set-option -g window-style 'bg=$SUBSTBG'
EOF
	(rsync -azus "$TMUXCONF" "$2":/tmp/tmux.tmp.conf &)
	# CONFIG=$(base64 -w 0 $TMUXCONF)
	ssh "$2" -t 'while [[ ! -f /tmp/tmux.tmp.conf ]]; do sleep 0.2; done && tmux -qf /tmp/tmux.tmp.conf new -As0'
	# ssh "$2" -t \
	# 	"[[ ! -f /tmp/tmux.tmp.conf ]] && echo $CONFIG | base64 -d > /tmp/tmux.tmp.conf;\
	# 		tmux -q -f /tmp/tmux.tmp.conf new -As0";
fi
