{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./hyprland.nix
    ./packages.nix

    inputs.noctalia.homeModules.default
  ];

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

    gtk2 = {
      enable = true;
      theme = "adw-gtk3-dark";

      # iconTheme = "Adwaita";
      # font = "Noto Sans 10";
      # cursorTheme = "breeze_cursors";

      extraConfig = ''
        gtk-cursor-theme-size=24
      '';
    };

    gtk3 = {
      enable = true;
      theme = "adw-gtk3-dark";

      # iconTheme = "Adwaita";
      # font = "Noto Sans 10";
      # cursorTheme = "breeze_cursors";

      extraConfig = ''
        gtk-cursor-theme-size=24
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4 = {
      enable = true;
      theme = "adw-gtk3-dark";

      # iconTheme = "Adwaita";
      # font = "Noto Sans 10";
      # cursorTheme = "breeze_cursors";

      extraConfig = ''
        gtk-cursor-theme-size=24
        gtk-application-prefer-dark-theme=1
      '';
    };
    
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
  };
}
