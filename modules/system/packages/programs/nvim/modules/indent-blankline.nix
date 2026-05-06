/*
  modules/system/packages/programs/nvim/modules/indent-blankline.nix

  created by ludw
  on 2026-04-24
*/

{
  # add indentation guides even on blank lines
  # https://nix-community.github.io/nixvim/plugins/indent-blankline/index.html
  # see `:help ibl`
  plugins.indent-blankline = {
    enable = true;
  };
}
