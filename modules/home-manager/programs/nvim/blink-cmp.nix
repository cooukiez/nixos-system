/*
  modules/home-manager/programs/nvim/blink-cmp.nix

  created by ludw
  on 2026-01-29
*/

{
  # snippet engine for Neovim
  # https://nix-community.github.io/nixvim/plugins/luasnip/index.html
  plugins.luasnip.enable = true;

  # https://nix-community.github.io/nixvim/plugins/cmp/index.html
  # see `:help cmp`
  plugins.blink-cmp = {
    enable = true;

    settings = {

      keymap = {
        # see `:help ins-completion`
        # see `:help blink-cmp-config-keymap`
        preset = "default";

        # for more advanced Luasnip keymaps
        # https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      };

      appearance = {
        nerd_font_variant = "mono";
      };

      completion = {
        documentation = {
          auto_show = false;
          auto_show_delay_ms = 500;
        };
      };

      sources = {
        default = [
          "lsp"
          "path"
          "snippets"
          "lazydev"
        ];
        providers = {
          lazydev = {
            module = "lazydev.integrations.blink";
            score_offset = 100;
          };
        };
      };

      snippets = {
        preset = "luasnip";
      };

      # see `:help blink-cmp-config-fuzzy`
      fuzzy = {
        implementation = "lua";
      };

      # shows a signature help window while you type arguments for a function
      signature = {
        enabled = true;
      };
    };
  };
}
