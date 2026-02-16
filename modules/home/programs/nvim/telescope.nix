/*
  modules/home/programs/nvim/telescope.nix

  created by ludw
  on 2026-02-16
*/

{
  # fuzzy finder (files, lsp, etc)
  # https://nix-community.github.io/nixvim/plugins/telescope/index.html
  plugins.telescope = {
    # see `:help telescope`
    # see `:help telescope.setup()`
    enable = true;

    # enable telescope extensions
    extensions = {
      # https://github.com/nvim-telescope/telescope-fzf-native.nvim
      fzf-native.enable = true;
      # https://github.com/nvim-telescope/telescope-ui-select.nvim
      ui-select.enable = true;
    };

    # see `:help telescope.builtin`
    keymaps = {
      "<leader>sh" = {
        mode = "n";
        action = "help_tags";
        options = {
          desc = "[S]earch [H]elp";
        };
      };
      "<leader>sk" = {
        mode = "n";
        action = "keymaps";
        options = {
          desc = "[S]earch [K]eymaps";
        };
      };
      "<leader>sf" = {
        mode = "n";
        action = "find_files";
        options = {
          desc = "[S]earch [F]iles";
        };
      };
      "<leader>ss" = {
        mode = "n";
        action = "builtin";
        options = {
          desc = "[S]earch [S]elect Telescope";
        };
      };
      "<leader>sw" = {
        mode = "n";
        action = "grep_string";
        options = {
          desc = "[S]earch current [W]ord";
        };
      };
      "<leader>sg" = {
        mode = "n";
        action = "live_grep";
        options = {
          desc = "[S]earch by [G]rep";
        };
      };
      "<leader>sd" = {
        mode = "n";
        action = "diagnostics";
        options = {
          desc = "[S]earch [D]iagnostics";
        };
      };
      "<leader>sr" = {
        mode = "n";
        action = "resume";
        options = {
          desc = "[S]earch [R]esume";
        };
      };
      "<leader>s." = {
        mode = "n";
        action = "oldfiles";
        options = {
          desc = "[S]earch Recent Files ('.' for repeat)";
        };
      };
      "<leader><leader>" = {
        mode = "n";
        action = "buffers";
        options = {
          desc = "[ ] Find existing buffers";
        };
      };
    };
    settings = {
      extensions.__raw = "{ ['ui-select'] = { require('telescope.themes').get_dropdown() } }";
    };
  };

  # https://nix-community.github.io/nixvim/keymaps/index.html
  keymaps = [
    # slightly advanced example of overriding default behavior and theme
    {
      mode = "n";
      key = "<leader>/";
      # additional configuration to telescope to change the theme, layout, etc.
      action.__raw = ''
        function()
          require('telescope.builtin').current_buffer_fuzzy_find(
            require('telescope.themes').get_dropdown {
              winblend = 10,
              previewer = false
            }
          )
        end
      '';
      options = {
        desc = "[/] Fuzzily search in current buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>s/";
      # possible to pass additional configuration options
      # see `:help telescope.builtin.live_grep()`
      action.__raw = ''
        function()
          require('telescope.builtin').live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files'
          }
        end
      '';
      options = {
        desc = "[S]earch [/] in Open Files";
      };
    }
    # shortcut for searching your nvim config
    {
      mode = "n";
      key = "<leader>sn";
      action.__raw = ''
        function()
          require('telescope.builtin').find_files {
            cwd = vim.fn.stdpath 'config'
          }
        end
      '';
      options = {
        desc = "[S]earch [N]eovim files";
      };
    }
  ];
}
