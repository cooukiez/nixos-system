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
      base00 = "#1C1C1C";
      base01 = "#232323";
      base02 = "#2E2E2E";
      base03 = "#6F6F6F";
      base04 = "#9D9D9D";
      base05 = "#CBCBCB";
      base06 = "#DCDCDC";
      base07 = "#E3E3E3";

      base08 = "#d21d3b";
      base09 = "#db4a62";
      base0A = "#e47789";
      base0B = "#eda4b0";
      base0C = "#0cabba";
      base0D = "#d21d3b";
      base0E = "#a02edd";
      base0F = "#e16b30";
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

  home.file.".config/noctalia/colors.json".text = ''
    {
      "mPrimary": "#ffffff",
      "mOnPrimary": "#1b1b1b",

      "mSecondary": "#c6c6c6",
      "mOnSecondary": "#1b1b1b",

      "mTertiary": "#e2e2e2",
      "mOnTertiary": "#1b1b1b",

      "mError": "#ffb4ab",
      "mOnError": "#690005",

      "mSurface": "#131313",
      "mOnSurface": "#e2e2e2",

      "mSurfaceVariant": "#1f1f1f",
      "mOnSurfaceVariant": "#c6c6c6",
      
      "mOutline": "#474747",
      "mShadow": "#000000",

      "mHover": "#e2e2e2",
      "mOnHover": "#1b1b1b"
    }
  '';

  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      button-layout = lib.mkForce ":";
    };
    "org/gnome/desktop/interface" = {
      color-scheme = lib.mkForce "prefer-dark";
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
