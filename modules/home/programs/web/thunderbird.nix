/*
  modules/home/programs/web/thunderbird.nix

  created by ludw
  on 2026-01-29
*/

{
  pkgs,
  ...
}:
{
  programs.thunderbird = {
    enable = true;
    package = pkgs.unstable.thunderbird;

    profiles.default = {
      isDefault = true;

      settings = {
        # performance
        "gfx.webrender.all" = true;
        "layers.acceleration.force-enabled" = true;
        "media.hardware-video-decoding.enabled" = true;
        "network.http.pipelining" = true;
        "network.http.pipelining.maxrequests" = 8;

        # desktop integration
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "widget.use-xdg-desktop-portal.settings" = 1;
        "widget.gtk.global-menu.enabled" = true;
        "widget.gtk.global-menu.wayland.enabled" = true;
        "widget.gtk.native-context-menus" = false;

        # custom stylesheets
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };

      userChrome = ''
        .titlebar-buttonbox-container {
          display: none !important;
        }

        .titlebar-spacer {
          display: none !important;
        }
      '';
    };
  };
}
