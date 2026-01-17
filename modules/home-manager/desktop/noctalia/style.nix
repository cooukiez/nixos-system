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

    gtk4.extraConfig = {
      gtk-theme-name = "adw-gtk3-dark";
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
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };
}