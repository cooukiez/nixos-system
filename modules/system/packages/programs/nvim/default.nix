/*
modules/system/packages/programs/nvim/default.nix

part of nixos system
created 2026-06-16 by ludw
*/
{
  inputs,
  pkgs,
  lib,
  ...
}: let
  # read all files in the modules directory
  files = builtins.readDir ./modules;

  # filter out non nix files
  nixFiles = builtins.filter (name: builtins.match ".*\\.nix" name != null) (
    builtins.attrNames files
  );

  # create a list of import statements
  fileImports = map (name: ./modules + "/${name}") nixFiles;
in {
  imports = [
    inputs.nixvim.nixosModules.nixvim
  ];

  options.programs.neovim.initLua = lib.mkOption {
    type = lib.types.str;
    default = "";
  };

  config.programs.nixvim = {
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
              italic = true;
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

      # gpg_encryption_method = "symmetric";
      # gpg_use_agent = 1;

      # GPGPreferArmor = 1;
      # GPGPreferSign = 1;

      /*
      GPGDefaultRecipients = [
        "ludwig.geyer@mailbox.org"
      ];
      */
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
      number = true;
      relativenumber = false;

      # global statusline
      laststatus = 3;
      showmode = false;

      mouse = "a";

      breakindent = true;
      undofile = true;

      ignorecase = true;
      smartcase = true;

      # keep signcolumn on
      signcolumn = "yes";

      updatetime = 250;
      timeoutlen = 300;

      # configure new splits
      splitright = true;
      splitbelow = true;

      # displaying whitespace characters
      # see `:help 'list'`
      # and `:help 'listchars'`
      list = true;
      listchars.__raw = "{ tab = '» ', trail = '·', nbsp = '␣' }";

      # preview substitutions live
      inccommand = "split";

      cursorline = true;
      scrolloff = 10;

      # if performing failing operation
      # ask to save the current file
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

      # normal editor saving
      {
        mode = [
          "n"
          "i"
          "v"
        ];
        key = "<C-s>";
        action = "<cmd>w<CR>";
        options = {
          desc = "Save file";
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
        event = ["TextYankPost"];
        desc = "Highlight when yanking (copying) text";
        group = "kickstart-highlight-yank";
        callback.__raw = ''
          function()
            vim.hl.on_yank()
          end
        '';
      }
      {
        event = [
          "BufReadPre"
          "FileReadPre"
        ];
        pattern = [
          "*.gpg"
          "*.pgp"
          "*.asc"
        ];
        desc = "Disable security-risky features for encrypted files";
        callback.__raw = ''
          function()
            vim.opt_local.swapfile = false
            vim.opt_local.undofile = false
            vim.opt_local.shada = ""
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
      # adds icons for plugins
      web-devicons.enable = true;

      # detect tabstop and shiftwidth automatically
      # https://nix-community.github.io/nixvim/plugins/sleuth/index.html
      guess-indent = {
        enable = true;
      };
    };

    # https://nix-community.github.io/nixvim/NeovimOptions/index.html#extraplugins
    extraPlugins = with pkgs.vimPlugins; [
      # not implemented plugins
      vim-gnupg
    ];

    # https://nix-community.github.io/nixvim/NeovimOptions/index.html#extraconfigluapost
    extraConfigLuaPost = ''
      -- line beneath this is called `modeline`
      -- see `:help modeline`
      -- vim: ts=2 sts=2 sw=2 et
    '';
  };
}
