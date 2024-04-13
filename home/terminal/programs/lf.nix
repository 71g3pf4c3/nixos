{ config, pkgs, unstable, lib, inputs, ... }: {
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
      zi = "	\${{\n			zoxide query --interactive | cd \n	}}\n";
      kubeapply = "	\${{\n			kubectl apply -f  \"$fx\"\n	}}\n";
      copy-path = "	\${{\n			printf \"$fx\" | ${pkgs.wl-clipboard}/bin/wl-copy \n	}}\n";
      dragdrop = "	\${{\n			printf '%s\\n' \"$fx\" | dragon -a -x -T -I \n	}}\n";
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
}
