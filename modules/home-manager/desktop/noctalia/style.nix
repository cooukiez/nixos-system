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

    base16Scheme = {
      base00 = "#101010";
      base01 = "#252525";
      base02 = "#464646";
      base03 = "#525252";
      base04 = "#ababab";
      base05 = "#b9b9b9";
      base06 = "#e3e3e3";
      base07 = "#f7f7f7";
      
      base08 = "#7c7c7c";
      base09 = "#999999";
      base0A = "#a0a0a0";
      base0B = "#8e8e8e";
      base0C = "#868686";
      base0D = "#686868";
      base0E = "#747474";
      base0F = "#5e5e5e";
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

  home.file.".config/noctalia/colors-bak.json".text = ''
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