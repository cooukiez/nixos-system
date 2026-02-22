/*
  modules/home/programs/nvim/mini.nix

  created by ludw
  on 2026-02-21
*/

{
  # collection of various small independent plugins/modules
  # https://nix-community.github.io/nixvim/plugins/mini.html
  plugins.mini = {
    enable = true;

    modules = {
      # better around/inside textobjects
      ai = {
        n_lines = 500;
      };

      # add/delete/replace surroundings (brackets, quotes, etc.)
      surround = {
      };

      # simple and easy statusline
      statusline = {
        use_icons.__raw = "vim.g.have_nerd_font";
      };

      # see https://github.com/echasnovski/mini.nvim
    };
  };

  # configure sections in the statusline by overriding their default behavior
  # https://nix-community.github.io/nixvim/NeovimOptions/index.html#extraconfiglua
  extraConfigLua = ''
    require('mini.statusline').section_location = function()
      return '%2l:%-2v'
    end
  '';
}
