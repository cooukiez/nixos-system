/*
modules/system/packages/programs/nvim/modules/autopairs.nix

part of nixos system
created 2026-06-16 by ludw
*/
{
  # inserts matching pairs of parens, brackets, etc.
  # https://nix-community.github.io/nixvim/plugins/nvim-autopairs/index.html
  plugins.nvim-autopairs = {
    enable = true;
  };
}
