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

    /*
    base16Scheme = {
      base00 = "#131313"; # background (mSurface)
      base01 = "#1f1f1f"; # surface variant
      base02 = "#474747"; # outline
      base03 = "#c6c6c6"; # secondary text / comments
      base04 = "#e2e2e2"; # tertiary text
      base05 = "#e2e2e2"; # default foreground (mOnSurface)
      base06 = "#6e6e6e"; # primary foreground
      base07 = "#6e6e6e"; # bright foreground

      base08 = "#ffb4ab"; # error
      base09 = "#e2e2e2"; # hover / highlight
      base0A = "#c6c6c6"; # secondary
      base0B = "#ffffff"; # primary
      base0C = "#e2e2e2"; # tertiary
      base0D = "#ffffff"; # accent
      base0E = "#c6c6c6"; # secondary accent
      base0F = "#690005"; # error foreground
    };
    */

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


  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":";
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

  home.file.".config/gtk-3.0/gtk-bak.css".text = ''
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

  home.file.".config/gtk-4.0/gtk-bak.css".text = ''
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