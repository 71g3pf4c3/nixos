SUBSTCOLOR="$(printf '%s' "$HOST" | md5sum | cut -c1-6)"
SUBSTBG="$(pastel lighten 0.4 "$SUBSTCOLOR" | pastel mix f2e5bc | pastel format hex)"
tmux select-pane -P "bg=$SUBSTBG"
