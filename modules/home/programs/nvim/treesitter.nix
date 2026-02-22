/*
  modules/home/programs/nvim/treesitter.nix

  created by ludw
  on 2026-02-21
*/

{ pkgs, ... }:
{
  # highlight, edit, and navigate code
  # https://nix-community.github.io/nixvim/plugins/treesitter/index.html
  plugins.treesitter = {
    enable = true;

    # installing tree-sitter grammars from nixpkgs (recommended)
    # https://nix-community.github.io/nixvim/plugins/treesitter/index.html#installing-tree-sitter-grammars-from-nixpkgs

    # grammarPackages = pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars;
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      # linux
      bash
      ssh_config
      # sway
      tmux

      # nix
      nix
      query # treesitter queries
      vim
      vimdoc
      # lua
      # luadoc

      # general development
      csv
      diff
      editorconfig
      git_config
      git_rebase
      gitattributes
      gitcommit
      gitignore
      ini
      # llvm
      markdown
      markdown_inline
      regex
      # xml
      yaml

      # rust development
      rust
      toml

      # web development
      css
      html
      # http
      javascript
      json
      # json5
      # php
      # php_only
      # phpdoc
      # sql
      # scss
      # twig
      # tsx
      # typescript

      # web/other
      # astro
      # nginx
      # svelte
    ];

    settings = {
      # installing tree-sitter grammars from nvim-treesitter
      # (can be combined with nixpkgs)
      # https://nix-community.github.io/nixvim/plugins/treesitter/index.html#installing-tree-sitter-grammars-from-nvim-treesitter
      ensureInstalled = [
      ];

      highlight = {
        enable = true;

        additional_vim_regex_highlighting = [
          "ruby"
        ];
      };

      indent = {
        enable = true;
        disable = [
          "ruby"
        ];
      };
    };
  };
}
