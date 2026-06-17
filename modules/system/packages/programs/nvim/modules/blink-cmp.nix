/*
modules/system/packages/programs/nvim/modules/blink-cmp.nix

part of nixos system
created 2026-06-16 by ludw
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

        # for more advanced lausnip keymaps
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

      # signature help window while you type arguments
      signature = {
        enabled = true;
      };
    };
  };
}
