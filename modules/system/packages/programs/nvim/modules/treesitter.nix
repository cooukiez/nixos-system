/*
modules/system/packages/programs/nvim/modules/treesitter.nix

part of nixos system
created 2026-04-24 by ludw
*/
{pkgs, ...}: {
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
      sway
      tmux

      # nix
      nix
      query
      vim
      vimdoc
      lua
      luadoc

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
      llvm
      markdown
      markdown_inline
      regex
      xml
      yaml

      # rust development
      rust
      toml

      # web development
      astro
      css
      html
      http
      javascript
      json
      json5
      nginx
      php
      php_only
      phpdoc
      scss
      sql
      svelte
      tsx
      twig
      typescript

      # other
      powershell
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
