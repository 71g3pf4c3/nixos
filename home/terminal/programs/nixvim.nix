{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox = {
      enable = true;
      settings = {
        terminal_colors = true;
        undercurl = true;
        underline = true;
        transparent_mode = false;
        background = "light";
        bold = true;
        italic = {
          strings = true;
          comments = true;
          operators = true;
          folds = true;
        };
        strikethrough = true;
        invert_selection = false;
        invert_signs = false;
        invert_tabline = false;
        invert_intend_guides = false;
        inverse = true;
        contrast = "soft";
        overrides = { };
      };
    };
    clipboard.providers.wl-copy.enable = true;
    clipboard.register = "unnamedplus";
    opts = {
      background = "light";
      mouse = "a";
      cursorline = true;
      cursorcolumn = true;
      number = true;
      title = true;
      shiftwidth = 2;
      tabstop = 2;
      autoindent = true;
      undofile = true;
      hlsearch = true;
      ignorecase = true;
      smartcase = true;
      wrap = false;
      laststatus = 3;
      timeoutlen = 200;
      conceallevel = 2;
      ch = 0;
    };
    globals = {
      loaded_python3_provider = 0;
      loaded_perl_provider = 0;
      mapleader = "\\";
    };

    plugins = {
      gitblame.enable = true;
      which-key.enable = true;
      lualine.enable = true;
      transparent.enable = true;
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings.allow_fullfuzzy_matching = true;
        settings = {
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "treesitter"; }
            { name = "dictionary"; }
            { name = "buffer"; }
            { name = "tmux"; }
            { name = "path"; }
            { name = "cmdline"; }
            { name = "emoji"; }
          ];
        };
        cmdline = {
          "/" = {
            mapping = {
              __raw = "cmp.mapping.preset.cmdline()";
            };
            sources = [ { name = "buffer"; } ];
          };
          ":" = {
            mapping = {
              __raw = "cmp.mapping.preset.cmdline()";
            };
            sources = [
              { name = "path"; }
              {
                name = "cmdline";
                option = {
                  ignore_cmds = [
                    "Man"
                    "!"
                  ];
                };
              }
            ];
          };
        };
      };
      cmp-tmux.enable = true;
      cmp-git.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp-cmdline.enable = true;
      cmp-dictionary.enable = true;
      cmp-emoji.enable = true;
      cmp_luasnip.enable = true;
      cmp-treesitter.enable = true;
      cmp-nvim-lsp.enable = true;
      tmux-navigator.enable = true;
      project-nvim.enable = true;
      nix.enable = true;
      gitsigns.enable = true;
      fugitive.enable = true;
      lazy.enable = true;
      # startup.enable = true;
      nvim-autopairs.enable = true;
      surround.enable = true;
      indent-blankline.enable = true;
      neorg = {
        enable = false;
        modules = {
          "core.defaults" = {
            __empty = null;
          };
          "core.integrations.treesitter" = {
            __empty = null;
          };
          "core.looking-glass" = {
            __empty = null;
          };
          "core.integrations.nvim-cmp" = {
            __empty = null;
          };
          "core.ui" = {
            __empty = null;
          };
          "core.export" = {
            __empty = null;
          };
          "core.export.markdown" = {
            __empty = null;
          };
          "core.concealer" = {
            config = {
              folds = true;
              icon_preset = "varied";
            };
          };
          "core.dirman" = {
            config = {
              workspaces = {
                work = "~/projects/runity";
              };
            };
          };
          "core.completion" = {
            config = {
              engine = "nvim-cmp";
            };
          };
          "core.promo" = {
            __empty = null;
          };
          "core.journal" = {
            __empty = null;
          };
        };
      };
      telescope = {
        enable = true;
        highlightTheme = "gruvbox";
      };
      clipboard-image = {
        enable = true;
        clipboardPackage = pkgs.wl-clipboard;
      };
      bufferline.enable = true;
      comment.enable = true;
      luasnip.enable = true;
      nvim-colorizer.enable = true;
      # sniprun.enable = true;
      treesitter-context.enable = true;
      treesitter-textobjects.enable = true;
      treesitter-refactor.enable = true;
      undotree.enable = true;
      treesitter = {
        enable = true;
        ensureInstalled = "all";
      };
      lsp-lines.enable = true;
      lsp-format.enable = true;
      conform-nvim = {
        enable = true;
        formatOnSave = ''
          function()
             require("conform").format({ async = true, lsp_fallback = true, range = range })
          end
        '';
        formattersByFt = {
          lua = [ "stylua" ];
          python = [
            "isort"
            "black"
          ];
          nix = [
            "nixfmt"
            "alejandra"
          ];
          sh = [
            "shellcheck"
            "shellharden"
          ];
          go = [
            "goimports"
            "gofmt"
          ];
          yaml = [
            "yamlfix"
            "yq"
          ];
          terraform = [ "terraform_fmt" ];
          json = [
            "fixjson"
            "jq"
          ];
          "*" = [
            "codespell"
            "trim_whitespace"
            "trim_newlines"
          ];
        };
      };
      lspkind.enable = true;

      diffview.enable = true;
      lsp = {
        enable = true;
        servers = {
          ansiblels.enable = true;
          helm-ls.enable = true;
          gopls.enable = true;
          yamlls.enable = true;
          nixd.enable = true;
          sqls.enable = true;
          terraformls.enable = true;
          dockerls.enable = true;
          pylsp.enable = true;
        };
      };
    };
    keymaps = [
      {
        key = "yf";
        action = ":!echo %:p | wl-copy<cr>";

        options = {
          silent = true;
          desc = "copy filepath";
        };
      }
      {
        key = "<leader>e";
        lua = true;
        action = ''function() require("b64").encode() end'';
        mode = "v";
        options = {
          desc = "encode base64";
          silent = true;
        };
      }
      {
        key = "<leader>d";
        lua = true;
        action = ''function() require("b64").decode() end'';
        options = {
          desc = "decode base64";
          silent = true;
        };
        mode = "v";
      }
      {
        key = "<leader>c";
        action = ":w !sed 's/.*: //g' | base64 -d | wl-copy<cr>";
        options = {
          desc = "copy decode base64";
          silent = true;
        };
        mode = "v";
      }
      {
        key = "<leader>k";
        action = ":w !kubectl apply -f -<cr>";
        options = {
          desc = "apply kube";
          silent = true;
        };
        mode = "v";
      }
      {
        key = "t";
        action = ":bn<Return>";
        options = {
          desc = "next tab";
          silent = true;
        };
        mode = "n";
      }
      {
        key = "T";
        action = ":bp<Return>";
        options = {
          desc = "previous tab";
          silent = true;
        };
        mode = "n";
      }
      {
        key = "<C-s>";
        action = ":w<Return>";
        options = {
          desc = "Save";
          silent = true;
        };
        mode = "n";
      }
      {
        key = "<C-z>";
        action = ":q!<Return>";
        options = {
          desc = "Quit";
          silent = true;
        };
        mode = "n";
      }
      {
        key = "<S-a>";
        action = "gg<S-v>G";
        options = {
          desc = "Select all";
          silent = true;
        };
        mode = "n";
      }
      {
        key = "<leader>p";
        lua = true;
        action = ''function() require("telescope").extensions.projects.projects({}) end'';
        options = {
          desc = "Projects";
          silent = true;
        };
      }
      {
        key = "<leader>f";
        lua = true;
        action = ''function() require("telescope.builtin").find_files() end'';
        options = {
          desc = "Find files";
          silent = true;
        };
      }
      {
        key = "<leader>b";
        lua = true;
        action = ''function() require("telescope.builtin").buffers() end'';
        options = {
          desc = "List buffers";
          silent = true;
        };
      }
      {
        key = "<leader>o";
        lua = true;
        action = ''function() require("telescope.builtin").oldfiles() end'';
        options = {
          desc = "History";
          silent = true;
        };
      }
      {
        key = "<leader>j";
        lua = true;
        action = ''function() require("telescope.builtin").jumplist() end'';
        options = {
          desc = "Find files";
          silent = true;
        };
      }
      {
        key = "<leader>h";
        lua = true;
        action = ''function() require("telescope.builtin").help_tags() end'';
        options = {
          desc = "Help tags";
          silent = true;
        };
      }
      {
        key = "<leader>x";
        lua = true;
        action = ''function() require("telescope.builtin").live_grep() end'';
        options = {
          desc = "Telegrep";
          silent = true;
        };
      }
      {
        key = "<leader>x";
        lua = true;
        action = ''function() require("telescope.builtin").current_buffer_fuzzy_find() end'';
        options = {
          desc = "Fuzzy find";
          silent = true;
        };
      }
      {
        key = "<leader>m";
        lua = true;
        action = ''function() require("telescope.builtin").marks() end'';
        options = {
          desc = "Marks";
          silent = true;
        };
      }
      {
        key = "<leader>l";
        action = ":<Esc>";
        options = {
          desc = "LSP";
          silent = true;
        };
        mode = "n";
      }
      {
        key = "<leader>lr";
        lua = true;
        action = ''function() require("telescope.builtin").lsp_references() end'';
        options = {
          desc = "References";
          silent = true;
        };
      }
      {
        key = "<leader>li";
        lua = true;
        action = ''function() require("telescope.builtin").lsp_implementations() end'';
        options = {
          desc = "Implementations";
          silent = true;
        };
      }
      {
        key = "<leader>ld";
        lua = true;
        action = ''function() require("telescope.builtin").lsp_definitions() end'';
        options = {
          desc = "Definitions";
          silent = true;
        };
      }
      {
        key = "<leader>lf";
        lua = true;
        action = ''function() require("telescope.builtin").diagnostics() end'';
        options = {
          desc = "Diagnostics";
          silent = true;
        };
      }
      {
        key = "<leader>gl";
        action = ":LazyGit<cr>";
        options = {
          desc = "Lazygit";
          silent = true;
        };
      }
      {
        key = "<leader>gb";
        lua = true;
        action = ''function() require("telescope.builtin").git_branches({}) end'';
        options = {
          desc = "Git branches";
          silent = true;
        };
      }
      {
        key = "<leader>;";
        lua = true;
        action = ''function() require("telescope.builtin").commands({}) end'';
        options = {
          desc = "Commands";
          silent = true;
        };
      }
      {
        key = "%";
        action = ":%s/";
        options = {
          desc = "Replace";
          silent = false;
        };
      }
      {
        key = "<leader>gs";
        lua = true;
        action = ''function() require("telescope.builtin").git_status({}) end'';
        options = {
          desc = "Git status";
          silent = true;
        };
      }
      {
        key = "<space>f";
        lua = true;
        action = ''
          function()
             require("conform").format({ async = true, lsp_fallback = true, range = range })
          end
        '';
        options = {
          desc = "Format";
          silent = true;
        };
        mode = "n";
      }
    ];
    extraPlugins = with pkgs.vimPlugins; [
      lazygit-nvim
    ];
  };
}
