{
  config,
  pkgs,
  unstable,
  lib,
  inputs,
  ...
}:
{

  xdg.configFile."lf/icons".source = ./icons;
  programs.lf = {
    enable = true;
    settings = {
      ratios = "1:1:2";
      ignorecase = true;
      hidden = false;
      info = "size:time";
      icons = true;
      preview = true;
    };
    previewer.source = "${lib.getExe pkgs.pistol}";
    keybindings = {
      D = "delete";
      gh = "cd ${config.home.homeDirectory}";
      gd = "cd ${config.home.homeDirectory}/tmp/downloads";
      gp = "cd ${config.home.homeDirectory}/var/projects";
      x = "live-grep";
      o = "dragdrop";
      R = "bulk-rename";
      E = "edit";
      C = "copy-content";
      P = "paste-content";
      KK = "kubeapply";
      KD = "kubedelete";
      f = "copy-path";
      T = "mkfile";
      F = "$xdg-open $(${lib.getExe pkgs.fzf})";
      M = "push $mkdir<space>";
      Z = "zi";
      S = "create-link";
    };
    commands = {
      open = "cmd open $xdg-open $fx";
      live-grep = ''
        ''${{
          nvim -c ':lua require("telescope.builtin").live_grep()'
        }}
      '';
      on-cd = ''
        &{{
          zoxide add "$PWD"
        }}
      '';
      zi = ''
        ''${{
        result=$(${lib.getExe pkgs.zoxide} query --interactive)
        cd -- $result
        }}
      '';
      kubeapply = "	\${{\n			${lib.getExe pkgs.kubectl} apply -f  \"$fx\"\n	}}\n";
      kubedelete = "	\${{\n			${lib.getExe pkgs.kubectl} delete -f  \"$fx\"\n	}}\n";
      copy-path = "	\${{\n			printf \"$fx\" | ${pkgs.wl-clipboard}/bin/wl-copy \n	}}\n";
      dragdrop = "	\${{\n			printf '%s\\n' \"$fx\" | ${lib.getExe pkgs.xdragon} -a -x -T -I \n	}}\n";
      create-link = ''
        ''${{
          name="$(basename $fx)"
          ln -s "$fx" "$name"
          }}
      '';
      copy-content = ''
        ''${{
        cat $fx | ${pkgs.wl-clipboard}/bin/wl-copy
            }}
      '';
      paste-content = ''
          ''${{
        ${pkgs.wl-clipboard}/bin/wl-paste > $fx
          	}}
      '';
      fzf-select = ''
        ''${{
            res="$(find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune -o -print 2> /dev/null | sed 1d | cut -b3- | fzf +m)"
            if [ -d "$res" ] ; then
                cmd="cd"
            elif [ -f "$res" ] ; then
                cmd="select"
            else
                exit 0
            fi
            lf -remote "send $id $cmd \"$res\""
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
}
