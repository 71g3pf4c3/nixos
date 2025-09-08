{ pkgs, lib, ... }:
let
  b64 = pkgs.vimUtils.buildVimPlugin {
    name = "b64-nvim";
    version = "unstable-2023-11-29";
    src = pkgs.fetchFromGitHub {
      owner = "taybart";
      repo = "b64.nvim";
      rev = "e93d1a7e065f6eaf5d3bae9efb9bc2c30907f471";
      hash = "sha256-hbXtM5L5e5gC2L9Dgr5uN15/5Fau+arlWIMAqTHf+pk=";
    };

    meta = {
      description = "Base64 encode and decode inside of neovim";
      homepage = "https://github.com/taybart/b64.nvim";
    };
  };
in
{
  home.packages = with pkgs; [
    shellcheck
    shellharden
    nixfmt-rfc-style
    codespell
    luajitPackages.lua-utils-nvim
    stylua
    tree-sitter
  ];
  programs.nixvim = {
    enable = true;
    # performance.combinePlugins.enable = true;
    # performance.byteCompileLua.enable = true;
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
      web-devicons.enable = true;
      # gitblame.enable = true;
      # gitgutter.enable = true;
      # zk = {
      #   enable = true;
      #   picker = "telescope";
      #   lsp = {
      #     autoAttach.enabled = true;
      #     config.cmd = [
      #       "zk"
      #       "lsp"
      #     ];
      #   };
      # };
      which-key.enable = true;
      lualine = {
        enable = true;
        extensions = [
          "fzf"
          "nvim-tree"
          "lazy"
          "nvim-tree"
          "fugitive"
          "ctrlspace"
        ];
      };
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
      # project-nvim.enable = true;
      nix.enable = true;
      gitsigns = {
        enable = true;
        settings = {
          current_line_blame = true;
        };
      };
      fugitive.enable = true;
      # startup.enable = true;
      nvim-autopairs.enable = true;
      vim-surround.enable = true;
      indent-blankline.enable = true;
      # neorg = {
      #   lazyLoading = true;
      #   enable = true;
      #   modules = {
      #     "core.defaults" = {
      #       __empty = null;
      #     };
      #     "core.integrations.treesitter" = {
      #       __empty = null;
      #     };
      #     "core.looking-glass" = {
      #       __empty = null;
      #     };
      #     "core.integrations.nvim-cmp" = {
      #       __empty = null;
      #     };
      #     "core.ui" = {
      #       __empty = null;
      #     };
      #     "core.export" = {
      #       __empty = null;
      #     };
      #     "core.export.markdown" = {
      #       __empty = null;
      #     };
      #     "core.concealer" = {
      #       config = {
      #         folds = true;
      #         icon_preset = "varied";
      #       };
      #     };
      #     "core.dirman" = {
      #       config = {
      #         workspaces = {
      #           work = "~/projects/runity";
      #         };
      #       };
      #     };
      #     "core.completion" = {
      #       config = {
      #         engine = "nvim-cmp";
      #       };
      #     };
      #     "core.journal" = {
      #       __empty = null;
      #     };
      #   };
      # };
      telescope = {
        enable = true;
        highlightTheme = "gruvbox";
        extensions = {
          advanced-git-search.enable = true;
        };
      };
      # codecompanion = {
      #   enable = true;
      #   settings = {
      #     adapters = {
      #       qwen = {
      #         __raw = ''
      #             function()
      #               return require('codecompanion.adapters').extend('ollama', {
      #                   env = {
      #                       url = "https://owebui.int.selectel.org/api",
      #                       api_key = "sk-d95abce881404af78256cc8ddaf104c0", -- optional: if your endpoint is authenticated
      #                   },
      #                   schema = {
      #                       model = {
      #                           default = 'qwen3-235b-a22b-fp8-instruct',
      #                           -- default = "llama3.1:8b-instruct-q8_0",
      #                       },
      #                       -- num_ctx = {
      #                       --     default = 32768,
      #                       -- },
      #                   },
      #               })
      #             end
      #         '';
      #       };
      #     };
      #   };
      # };
      # avante = {
      #   enable = true;
      #   settings = {
      #     provider = "qianwen";
      #     providers = {
      #       qianwen = {
      #         __inherited_from = "openai";
      #         api_key_name = "sk-d95abce881404af78256cc8ddaf104c0";
      #         endpoint = "https://owebui.int.selectel.org/api";
      #         model = "qwen3-235b-a22b-fp8-instruct";
      #       };
      #     };
      #   };
      # };
      clipboard-image = {
        enable = true;
        clipboardPackage = pkgs.wl-clipboard;
      };
      bufferline.enable = true;
      comment.enable = true;
      luasnip.enable = true;
      colorizer.enable = true;
      sniprun.enable = true;
      treesitter-context.enable = true;
      treesitter-textobjects.enable = true;
      treesitter-refactor.enable = true;
      undotree.enable = true;
      treesitter = {
        enable = true;
        ensureInstalled = "all";
        settings = {
          highlight = {
            enable = true;
            additional_vim_regex_highlighting = true;
          };
          sync_install = true;
          indent = {
            enable = true;
          };
          incremental_selection = {
            enable = true;
            keymaps = {
              init_selection = false;
              node_decremental = "grm";
              node_incremental = "grn";
              scope_incremental = "grc";
            };
          };
        };

      };
      lsp-lines.enable = true;
      # lsp-format = {
      #   enable = true;
      #   # lspServersToEnable = [ "all" ];
      # };
      conform-nvim = {
        enable = true;
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
          puppet = [
            "puppet-lint"
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
          # ansiblels.enable = true;
          helm_ls = {
            enable = true;
            filetypes = [
              "yaml"
              "yml"
              "tpl"
            ];
          };
          gopls.enable = true;
          # yamlls.enable = true;
          nixd.enable = true;
          sqls.enable = true;
          terraformls.enable = true;
          dockerls.enable = true;
          puppet = {
            enable = true;
            package = pkgs.puppet;

          };
          pylsp = {
            enable = true;
            settings = {
              plugins = {
                flake8 = {
                  enabled = true;
                  ignore = [ "E501" ];
                };
                black.enabled = true;
                ruff.enabled = true;
              };

            };
          };
          pyright.enable = true;
        };
      };
    };
    keymaps = [
      # {
      #   key = "yf";
      #   action = ":!echo %:p | wl-copy<cr>";
      #
      #   options = {
      #     silent = true;
      #     desc = "copy filepath";
      #   };
      # }
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
        key = "<leader>u";
        action = ":UndotreeToggle<cr>";
        options = {
          desc = "Toggle undotree";
          silent = true;
        };
        mode = "n";
      }
      {
        key = "<leader>gdl";
        action = ":AdvancedGitSearch diff_commit_line<cr>";
        options = {
          desc = "Diff commit line";
          silent = true;
        };
        mode = "n";
      }
      {
        key = "<leader>gdf";
        action = ":AdvancedGitSearch diff_commit_file<cr>";
        options = {
          desc = "Diff commit file";
          silent = true;
        };
        mode = "n";
      }
      {
        key = "<leader>gu";
        action = ":Gitsigns udo_stage_hunk<cr>";
        options = {
          desc = "Untage hunk";
          silent = true;
        };
        mode = "n";
      }
      {
        key = "<leader>gh";
        action = ":Gitsigns stage_hunk<cr>";
        options = {
          desc = "Stage hunk";
          silent = true;
        };
        mode = "n";
      }
      {
        key = "<leader>gu";
        action = ":Gitsigns udo_stage_hunk<cr>";
        options = {
          desc = "Untage hunk";
          silent = true;
        };
        mode = "v";
      }
      {
        key = "<leader>gh";
        action = ":Gitsigns stage_hunk<cr>";
        options = {
          desc = "Stage hunk";
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
    extraPlugins = [
      b64
    ];
  };
}
