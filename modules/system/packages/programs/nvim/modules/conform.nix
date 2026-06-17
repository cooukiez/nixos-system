/*
modules/system/packages/programs/nvim/modules/conform.nix

part of nixos system
created 2026-06-16 by ludw
*/
{pkgs, ...}: {
  # https://nix-community.github.io/nixvim/NeovimOptions/index.html#extrapackages
  extraPackages = with pkgs; [
    stylua
  ];

  # https://nix-community.github.io/nixvim/plugins/conform-nvim.html
  plugins.conform-nvim = {
    enable = true;
    settings = {
      notify_on_error = false;
      format_on_save = ''
        function(bufnr)
          local disable_filetypes = { }
          if disable_filetypes[vim.bo[bufnr].filetype] then
            return nil
          else
            return {
              timeout_ms = 500,
              lsp_format = "fallback",
            }
          end
        end
      '';
      formatters_by_ft = {
        lua = ["stylua"];

        python = [
          "isort"
          "black"
        ];
      };
    };
  };

  # https://nix-community.github.io/nixvim/keymaps/index.html
  keymaps = [
    {
      mode = "";
      key = "<leader>f";
      action.__raw = ''
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end
      '';
      options = {
        desc = "[F]ormat buffer";
      };
    }
  ];
}
