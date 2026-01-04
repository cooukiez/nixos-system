{ pkgs, userConfig, ... }:
{
  programs.firefox = {
    policies = {
      DefaultDownloadDirectory = "\${home}/Downloads";
    };
  };

  profiles.default = {
    id = 0;
    name = "default";
    isDefault = true;

    settings = {
        # performance
        "gfx.webrender.all" = true;
        "layers.acceleration.force-enabled" = true;
        "media.hardware-video-decoding.enabled" = true;
        "browser.cache.disk.enable" = false;
        "browser.cache.memory.enable" = true;
        "network.http.pipelining" = true;
        "network.http.pipelining.maxrequests" = 8;

        # ui tweaks
        "browser.tabs.drawInTitlebar" = true; # hides window buttons (see note below)
        "browser.compactmode.show" = true;
        "browser.uidensity" = 1; # compact

        # kde integration
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "widget.use-xdg-desktop-portal.settings" = 1;
        "widget.gtk.global-menu.enabled" = true;
        "widget.gtk.global-menu.wayland.enabled" = true;
        "widget.gtk.native-context-menus" = true;
        # full kde polish?
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        # sync
        "services.sync.engine.bookmarks" = true;
        "services.sync.engine.history" = true;
        "services.sync.engine.passwords" = true;
        "services.sync.engine.tabs" = true;
        "services.sync.engine.addons" = true;
      };

      # extensions can be declarative
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
#         ublock-origin
#         bitwarden
      ];
    };
  };
}
