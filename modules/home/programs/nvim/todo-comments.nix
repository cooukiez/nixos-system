/*
  modules/home/programs/nvim/todo-comments.nix

  created by ludw
  on 2026-02-18
*/

{
  # highlight todo, notes, etc. in comments
  # https://nix-community.github.io/nixvim/plugins/todo-comments/index.html
  plugins.todo-comments = {
    enable = true;
    settings = {
      signs = true;
    };
  };
}
