/*
modules/home/desktop/nn/packages.nix

part of nixos system
created 2026-06-16 by ludw
*/
{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.desktop.nn;
in {
  config = lib.mkIf cfg {
    home.packages = with pkgs; [
      adw-gtk3
      gtk3

      adwaita-icon-theme
      papirus-icon-theme

      adwaita-qt6
      kdePackages.qt6ct

      libsecret
      # lisgd
      zenity

      nwg-look
      dconf-editor

      gnome-online-accounts
      gsettings-desktop-schemas
    ];
  };
}
