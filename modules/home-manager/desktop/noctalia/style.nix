/*
  modules/home-manager/desktop/noctalia/style.nix

  created by ludw
  on 2026-01-29
*/

{
  pkgs,
  lib,
  ...
}:
{
  stylix = {
    enable = true;

    targets.noctalia-shell.enable = false;
    targets.kitty.enable = false;
    targets.firefox.enable = false;
    targets.zen-browser.enable = false;
    targets.vscode.enable = false;

    targets.firefox.profileNames = [ "default" ];
    targets.zen-browser.profileNames = [ "default" ];
    enableReleaseChecks = false;

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
        name = "JetBrainsMono Nerd Font";
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

    gtk3.extraConfig = {
      gtk-enable-animations = false;
      gtk-menu-popup-delay = 0;
    };

    gtk4.extraConfig = {
      gtk-theme-name = "adw-gtk3-dark";
      gtk-enable-animations = false;
      gtk-menu-popup-delay = 0;
    };

    cursorTheme = {
      name = "Adwaita";
      size = 24;
    };

    colorScheme = "dark";

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  qt = {
    enable = true;
    style.name = "Adwaita-Dark";

    qt6ctSettings = {
      Appearance = {
        color_scheme_path = "$HOME/.config/qt6ct/colors/noctalia.conf";
        custom_palette = true;
        standard_dialogs = "default";

        style = "Adwaita-Dark";
        icon_theme = "Papirus-Dark";
      };

      Fonts = {
        fixed = "\"JetBrainsMono NF, 10\"";
        general = "\"Inter, 10\"";
      };

      Interface = {
        activate_item_on_single_click = 1;
        buttonbox_layout = 2;
        cursor_flash_time = 1000;
        dialog_buttons_have_icons = 1;
        double_click_interval = 400;
        gui_effects = "@Invalid()";
        keyboard_scheme = 2;
        menus_have_icons = true;
        show_shortcuts_in_context_menus = true;
        stylesheets = "@Invalid()";
        toolbutton_style = 4;
        underline_shortcut = 1;
        wheel_scroll_lines = 3;
      };

      Troubleshooting = {
        force_raster_widgets = 1;
        ignored_applications = "@Invalid()";
      };
    };
  };
}
