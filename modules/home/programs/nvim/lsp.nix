/*
  modules/home-manager/programs/nvim/lsp.nix

  created by ludw
  on 2026-01-29
*/

{
  pkgs,
  ...
}:
{
  # useful status updates for lsp
  # https://nix-community.github.io/nixvim/plugins/fidget/index.html
  plugins.fidget = {
    enable = true;
  };

  # https://nix-community.github.io/nixvim/NeovimOptions/autoGroups/index.html
  autoGroups = {
    "kickstart-lsp-attach" = {
      clear = true;
    };
  };

  # plugin that properly configures luals for editing your nvim config
  # https://nix-community.github.io/nixvim/plugins/lazydev/index.html
  plugins.lazydev = {
    enable = true;
    settings = {
      library = [
        {
          path = "\${3rd}/luv/library";
          words = [ "vim%.uv" ];
        }
      ];
    };
  };

  # for difference between lsp and treesitter, see `:help lsp-vs-treesitter`
  # https://nix-community.github.io/nixvim/plugins/lsp/index.html
  plugins.lsp = {
    enable = true;

    # enable the following language servers
    # they will automatically be installed
    servers = {
      clangd = {
        enable = true;
      };
      rust_analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
      };
      nil_ls = {
        enable = true;
      };
      # gopls = {
      #   enable = true;
      # };
      # pyright = {
      #   enable = true;
      # };
      # ts_ls = {
      #   enable = true;
      # };
      #
      # see `https://nix-community.github.io/nixvim/plugins/lsp`
      #
      # some languages (like typscript) have entire language plugins
      # see `https://nix-community.github.io/nixvim/plugins/typescript-tools/index.html?highlight=typescript-tools#pluginstypescript-toolspackage`

      lua_ls = {
        enable = true;

        # cmd = { };
        # filetypes = { };
        settings = {
          completion = {
            callSnippet = "Replace";
          };
          # diagnostics = {
          #   disable = [
          #     "missing-fields"
          #   ];
          # };
        };
      };
    };

    keymaps = {
      diagnostic = {
        "<leader>q" = {
          mode = "n";
          action = "setloclist";
          desc = "Open diagnostic [Q]uickfix list";
        };
      };

      extra = [
        # find references for the word under your cursor
        {
          mode = "n";
          key = "grr";
          action.__raw = "require('telescope.builtin').lsp_references";
          options = {
            desc = "LSP: [G]oto [R]eferences";
          };
        }
        # jump to the implementation of the word under your cursor
        {
          mode = "n";
          key = "gri";
          action.__raw = "require('telescope.builtin').lsp_implementations";
          options = {
            desc = "LSP: [G]oto [I]mplementation";
          };
        }
        # jump to the definition of the word under your cursor
        {
          mode = "n";
          key = "grd";
          action.__raw = "require('telescope.builtin').lsp_definitions";
          options = {
            desc = "LSP: [G]oto [D]efinition";
          };
        }
        # fuzzy find all the symbols in your current document
        {
          mode = "n";
          key = "gO";
          action.__raw = "require('telescope.builtin').lsp_document_symbols";
          options = {
            desc = "LSP: Open Document Symbols";
          };
        }
        # fuzzy find all the symbols in your current workspace
        {
          mode = "n";
          key = "gW";
          action.__raw = "require('telescope.builtin').lsp_dynamic_workspace_symbols";
          options = {
            desc = "LSP: Open Workspace Symbols";
          };
        }
        # jump to the type of the word under your cursor
        {
          mode = "n";
          key = "grt";
          action.__raw = "require('telescope.builtin').lsp_type_definitions";
          options = {
            desc = "LSP: [G]oto [T]ype Definition";
          };
        }
      ];

      lspBuf = {
        # rename the variable under your cursor
        "grn" = {
          action = "rename";
          desc = "LSP: [R]e[n]ame";
        };
        # execute a code action, usually your cursor needs to be on top of an error
        "gra" = {
          mode = [
            "n"
            "x"
          ];
          action = "code_action";
          desc = "LSP: [G]oto Code [A]ction";
        };
        # WARN: this is not goto Definition, this is goto Declaration
        "grD" = {
          action = "declaration";
          desc = "LSP: [G]oto [D]eclaration";
        };
      };
    };

    # function gets run when an lsp attaches to a particular buffer
    onAttach = ''
      local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
      end

      ---@param client vim.lsp.Client
      ---@param method vim.lsp.protocol.Method
      ---@param bufnr? integer some lsp support methods only in specific files
      ---@return boolean
      local function client_supports_method(client, method, bufnr)
        if vim.fn.has 'nvim-0.11' == 1 then
          return client:supports_method(method, bufnr)
        else
          return client.supports_method(method, { bufnr = bufnr })
        end
      end

      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
          end,
        })
      end

      if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
        map('<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end, '[T]oggle Inlay [H]ints')
      end
    '';
  };
}
