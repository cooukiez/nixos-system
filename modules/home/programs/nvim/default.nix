/*
  modules/home-manager/programs/nvim/default.nix

  created by ludw
  on 2026-01-29
*/

{ config, pkgs, ... }:
let
  # read all files in the current directory
  files = builtins.readDir ./.;

  # filter out default.nix and non nix files
  nixFiles = builtins.filter (name: name != "default.nix" && builtins.match ".*\\.nix" name != null) (
    builtins.attrNames files
  );

  # create a list of import statements
  fileImports = map (name: ./. + "/${name}") nixFiles;
in
{
  programs.nixvim = {
    enable = true;
    version.enableNixpkgsReleaseCheck = false;

    imports = fileImports;

    colorschemes = {
      # https://nix-community.github.io/nixvim/colorschemes/tokyonight/index.html
      tokyonight = {
        enable = true;
        settings = {
          style = "night";
          styles = {
            comments = {
              # italic = false; # disable italics in comments
            };
          };
        };
      };
    };

    # https://nix-community.github.io/nixvim/NeovimOptions/index.html#globals
    globals = {
      # set space as the leader key
      mapleader = " ";
      maplocalleader = " ";

      have_nerd_font = true;
    };

    # see `:help 'clipboard'`
    clipboard = {
      providers = {
        wl-copy.enable = true; # for wayland
        xsel.enable = true; # for x11
      };

      # sync clipboard between os and nvim
      register = "unnamedplus";
    };

    # https://nix-community.github.io/nixvim/NeovimOptions/index.html#opts
    # see `:help vim.o`
    opts = {
      # show line numbers
      number = true;
      # can also add relative line numbers to help with jumping
      # relativenumber = true;

      # enable mouse mode
      mouse = "a";

      # do not show mode since we use statusline
      showmode = false;

      # enable break indent
      breakindent = true;

      # save undo history
      undofile = true;

      # case-insensitive searching UNLESS \C or one or more capital letters in the search term
      ignorecase = true;
      smartcase = true;

      # keep signcolumn on by default
      signcolumn = "yes";

      # decrease update time
      updatetime = 250;

      # decrease mapped sequence wait time
      timeoutlen = 300;

      # configure how new splits should be opened
      splitright = true;
      splitbelow = true;

      # sets how neovim will display certain whitespace characters in the editor
      # see `:help 'list'`
      # and `:help 'listchars'`
      list = true;
      # NOTE: `.__raw` here means that this field is raw lua code
      listchars.__raw = "{ tab = '» ', trail = '·', nbsp = '␣' }";

      # preview substitutions live
      inccommand = "split";

      # show which line cursor is on
      cursorline = true;

      # minimal number of screen lines to keep above and below the cursor
      scrolloff = 10;

      # if performing an operation that would fail
      # instead raise a dialog asking if you wish to save the current file
      # see `:help 'confirm'`
      confirm = true;

      # see `:help hlsearch`
      hlsearch = true;
    };

    # https://nix-community.github.io/nixvim/keymaps/index.html
    # see `:help vim.keymap.set()`
    keymaps = [
      # clear highlights on search when pressing esc in normal mode
      # see `:help hlsearch`
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
      }
      # exit terminal mode in the builtin terminal
      {
        mode = "t";
        key = "<Esc><Esc>";
        action = "<C-\\><C-n>";
        options = {
          desc = "Exit terminal mode";
        };
      }
      # disable arrow keys in normal mode
      /*
        {
          mode = "n";
          key = "<left>";
          action = "<cmd>echo 'Use h to move!!'<CR>";
        }
        {
          mode = "n";
          key = "<right>";
          action = "<cmd>echo 'Use l to move!!'<CR>";
        }
        {
          mode = "n";
          key = "<up>";
          action = "<cmd>echo 'Use k to move!!'<CR>";
        }
        {
          mode = "n";
          key = "<down>";
          action = "<cmd>echo 'Use j to move!!'<CR>";
        }
      */
      # keybinds to make split navigation easier
      # use ctrl+<hjkl> to switch between windows
      #
      # see `:help wincmd` for a list of all window commands
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w><C-h>";
        options = {
          desc = "Move focus to the left window";
        };
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w><C-l>";
        options = {
          desc = "Move focus to the right window";
        };
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w><C-j>";
        options = {
          desc = "Move focus to the lower window";
        };
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w><C-k>";
        options = {
          desc = "Move focus to the upper window";
        };
      }
    ];

    # https://nix-community.github.io/nixvim/NeovimOptions/autoGroups/index.html
    autoGroups = {
      kickstart-highlight-yank = {
        clear = true;
      };
    };

    # https://nix-community.github.io/nixvim/NeovimOptions/autoCmd/index.html
    # see `:help lua-guide-autocommands`
    autoCmd = [
      # highlight when yanking (copying) text
      # see `:help vim.hl.on_yank()`
      {
        event = [ "TextYankPost" ];
        desc = "Highlight when yanking (copying) text";
        group = "kickstart-highlight-yank";
        callback.__raw = ''
          function()
            vim.hl.on_yank()
          end
        '';
      }
    ];

    diagnostic = {
      settings = {
        severity_sort = true;
        float = {
          border = "rounded";
          source = "if_many";
        };
        underline = {
          severity.__raw = "vim.diagnostic.severity.ERROR";
        };
        signs.__raw = ''
          vim.g.have_nerd_font and {
            text = {
              [vim.diagnostic.severity.ERROR] = '󰅚 ',
              [vim.diagnostic.severity.WARN] = '󰀪 ',
              [vim.diagnostic.severity.INFO] = '󰋽 ',
              [vim.diagnostic.severity.HINT] = '󰌶 ',
            },
          } or {}
        '';
        virtual_text = {
          source = "if_many";
          spacing = 2;
          format.__raw = ''
            function(diagnostic)
              local diagnostic_message = {
                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                [vim.diagnostic.severity.WARN] = diagnostic.message,
                [vim.diagnostic.severity.INFO] = diagnostic.message,
                [vim.diagnostic.severity.HINT] = diagnostic.message,
              }
              return diagnostic_message[diagnostic.severity]
            end
          '';
        };
      };
    };

    plugins = {
      # adds icons for plugins to utilize in ui
      web-devicons.enable = true;

      # detect tabstop and shiftwidth automatically
      # https://nix-community.github.io/nixvim/plugins/sleuth/index.html
      guess-indent = {
        enable = true;
      };
    };

    # https://nix-community.github.io/nixvim/NeovimOptions/index.html#extraplugins
    extraPlugins = with pkgs.vimPlugins; [
      # add a vim plugin that is not implemented in nixvim
    ];

    # https://nix-community.github.io/nixvim/NeovimOptions/index.html#extraconfigluapost
    extraConfigLuaPost = ''
      -- The line beneath this is called `modeline`. See `:help modeline`
      -- vim: ts=2 sts=2 sw=2 et
    '';
  };
}
