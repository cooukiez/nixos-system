/*
  modules/home/programs/nvim/neo-tree.nix

  created by ludw
  on 2026-02-21
*/

{
  # plugin to browse the file system
  # https://nix-community.github.io/nixvim/plugins/neo-tree/index.html?highlight=neo-tree#pluginsneo-treepackage
  plugins.neo-tree = {
    enable = true;

    settings = {
      filesystem = {
        window = {
          mappings = {
            "<leader>e" = "close_window";
          };
        };
      };
    };
  };

  # https://nix-community.github.io/nixvim/keymaps/index.html
  keymaps = [
    {
      key = "<leader>e";
      action = "<cmd>Neotree reveal<cr>";
      options = {
        desc = "NeoTree reveal";
      };
    }
  ];
}
