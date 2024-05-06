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
