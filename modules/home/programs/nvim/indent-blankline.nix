/*
  modules/home/programs/nvim/indent-blankline.nix

  created by ludw
  on 2026-02-21
*/

{
  # add indentation guides even on blank lines
  # https://nix-community.github.io/nixvim/plugins/indent-blankline/index.html
  # see `:help ibl`
  plugins.indent-blankline = {
    enable = true;
  };
}
