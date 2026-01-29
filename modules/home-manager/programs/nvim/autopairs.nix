/*
  modules/home-manager/programs/nvim/autopairs.nix

  created by ludw
  on 2026-01-26
*/

{
  # inserts matching pairs of parens, brackets, etc.
  # https://nix-community.github.io/nixvim/plugins/nvim-autopairs/index.html
  plugins.nvim-autopairs = {
    enable = true;
  };
}
