/*
modules/system/packages/programs/nvim/modules/todo-comments.nix

part of nixos system
created 2026-04-24 by ludw
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
