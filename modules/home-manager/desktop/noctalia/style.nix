{
  pkgs,
  ...
}:
{
  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":";
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
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

    font = {
      name = "Inter";
      size = 10;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  home.file.".config/gtk-3.0/gtk.css".text = ''
    @define-color accent_color #6e6e6e;
    @define-color accent_bg_color #6e6e6e;
    @define-color accent_fg_color #1b1b1b;
    @define-color window_bg_color #131313;
    @define-color window_fg_color #e2e2e2;
    @define-color headerbar_bg_color #131313;
    @define-color headerbar_fg_color #e2e2e2;
    @define-color popover_bg_color #474747;
    @define-color popover_fg_color #c6c6c6;
    @define-color view_bg_color #131313;
    @define-color view_fg_color #e2e2e2;
    @define-color card_bg_color #131313;
    @define-color card_fg_color #e2e2e2;

    @define-color sidebar_bg_color #1f1f1f;
    @define-color sidebar_fg_color #e2e2e2;
    @define-color sidebar_border_color @window_bg_color;
    @define-color sidebar_backdrop_color @window_bg_color;
  '';

  home.file.".config/gtk-4.0/gtk.css".text = ''
    @define-color accent_color #6e6e6e;
    @define-color accent_bg_color #6e6e6e;
    @define-color accent_fg_color #1b1b1b;
    @define-color window_bg_color #131313;
    @define-color window_fg_color #e2e2e2;
    @define-color headerbar_bg_color #131313;
    @define-color headerbar_fg_color #e2e2e2;
    @define-color popover_bg_color #474747;
    @define-color popover_fg_color #c6c6c6;
    @define-color view_bg_color #131313;
    @define-color view_fg_color #e2e2e2;
    @define-color card_bg_color #131313;
    @define-color card_fg_color #e2e2e2;

    @define-color sidebar_bg_color #1f1f1f;
    @define-color sidebar_fg_color #e2e2e2;
    @define-color sidebar_border_color @window_bg_color;
    @define-color sidebar_backdrop_color @window_bg_color;
  '';

  qt = {
    enable = true;
    style.name = "Adwaita-Dark";

    qt6ctSettings = {
      Appearance = {
        color_scheme_path = "$HOME/.config/qt6ct/colors/noctalia.conf";
        custom_palette = true;
        icon_theme = "Papirus-Dark";
        standard_dialogs = "default";
        style = "Adwaita-Dark";
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