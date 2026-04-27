/*
  modules/home/desktop/nn/style.nix

  created by ludw
  on 2026-02-26
*/

{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.desktop.nn;
in
{
  imports = [
    inputs.stylix.homeModules.default
  ];

  config = lib.mkIf cfg {
    home.pointerCursor = {
      name = "McMojave-cursors";
      package = pkgs.mcmojave-cursor-theme;
      size = 24;
    };

    stylix = {
      enable = true;

      enableReleaseChecks = false;

      # configured seperately
      targets.firefox.enable = false;
      targets.hyprlock.colors.enable = false;
      targets.kitty.enable = false;
      targets.noctalia-shell.enable = false;
      targets.vscode.enable = false;
      targets.zen-browser.enable = false;

      targets.firefox.profileNames = [ "default" ];
      targets.zen-browser.profileNames = [ "default" ];

      # horizon base16
      base16Scheme = {
        base00 = "#101010";
        base01 = "#202020";
        base02 = "#2E2E2E";
        base03 = "#333333";
        base04 = "#999999";
        base05 = "#C1C1C1";
        base06 = "#999999";
        base07 = "#C1C1C1";

        base08 = "#3584E4";
        base09 = "#AAAAAA";
        base0A = "#70A9EB";
        base0B = "#D6E6F9";
        base0C = "#AAAAAA";
        base0D = "#3584E4";
        base0E = "#999999";
        base0F = "#444444";
      };

      fonts = {
        serif = {
          name = "Inter";
          package = pkgs.inter;
        };

        sansSerif = {
          name = "Inter";
          package = pkgs.inter;
        };

        monospace = {
          name = "JetBrainsMono NF";
          package = pkgs.nerd-fonts.jetbrains-mono;
        };

        emoji = {
          name = "Noto Color Emoji";
          package = pkgs.noto-fonts-color-emoji;
        };

        sizes = {
          applications = 10;
          terminal = 10;
          desktop = 10;
          popups = 10;
        };
      };
    };

    gtk = {
      enable = true;

      gtk2.theme = {
        package = pkgs.adw-gtk3;
        name = "adw-gtk3-dark";
      };

      gtk3.theme = {
        package = pkgs.adw-gtk3;
        name = "adw-gtk3-dark";
      };

      gtk4.extraConfig = {
        gtk-theme-name = "adw-gtk3-dark";
      };

      colorScheme = "dark";

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
    };

    qt = {
      enable = true;

      qt6ctSettings = {
        Appearance = {
          color_scheme_path = "${config.xdg.configHome}/qt6ct/colors/noctalia.conf";

          custom_palette = true;
          standard_dialogs = "default";

          style = lib.mkForce "Adwaita-Dark";
          icon_theme = "Papirus-Dark";
        };

        Interface = {
          activate_item_on_single_click = 1;
          double_click_interval = 400;
          cursor_flash_time = 1000;

          # layout style dialog button
          buttonbox_layout = 2;
          dialog_buttons_have_icons = 1;

          # toolbar button style
          toolbutton_style = 4;
          underline_shortcut = 1;

          keyboard_scheme = 2;

          # scroll lines per step
          wheel_scroll_lines = 3;

          menus_have_icons = true;
          show_shortcuts_in_context_menus = true;

          gui_effects = "@Invalid()";
          stylesheets = "@Invalid()";
        };

        Troubleshooting = {
          force_raster_widgets = 1;

          # list of apps ignored by qt6ct settings
          ignored_applications = "@Invalid()";
        };
      };
    };
  };
}
