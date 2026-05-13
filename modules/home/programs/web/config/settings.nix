/*
  modules/home/programs/web/config/settings.nix

  part of nixos system
  created 2026-04-28 by ludw
*/

{
  core = {
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

    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
  };

  firefoxCore = {
    # set locale
    "browser.search.region" = "DE";
    "browser.search.isUS" = false;
    "distribution.searchplugins.defaultLocale" = "en-US";
    "general.useragent.locale" = "en-Us";

    # performance
    "browser.cache.disk.enable" = false;
    "browser.cache.memory.enable" = true;

    # networking & local dns
    "browser.fixup.domainsuffixwhitelist.lan" = true;
    "browser.fixup.domainsuffixwhitelist.local" = true;

    # disable config warning
    "browser.aboutConfig.showWarning" = false;
    "browser.tabs.warnOnClose" = false;

    # sponsors
    "browser.newtabpage.activity-stream.system.showSponsored" = false;
    "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
    "browser.urlbar.suggest.quicksuggest.sponsored" = false;
    "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsored" = false;
    "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

    # content blocking
    "browser.contentblocking.category" = "strict";

    # extensions auto added
    "extensions.autoDisableScopes" = 0;

    # disable requirement for extension signatures
    "xpinstall.signatures.required" = false;

    # allow pipewire camera
    "media.webrtc.camera.allow-pipewire" = true;

    # 0 = blank
    # 1 = home page
    # 2 = last visited
    # 3 = previous session

    "browser.startup.page" = 0;
    "browser.startup.homepage" = "http://localhost/";
    "browser.newtabpage.enabled" = false;

    # new tab pinned
    "browser.newtabpage.pinned" = [ ];

    # default browser checks
    "browser.shell.checkDefaultBrowser" = false;

    # disable welcome / tips stuff
    "browser.aboutwelcome.enabled" = false;
    "browser.startup.firstrunSkipsHomepage" = true;

    "browser.uitour.url" = "";
    "browser.uitour.enabled" = false;

    "browser.tips.enabled" = false;
    "browser.vpn_promo.enabled" = false;
    "browser.promo.focus.enabled" = false;

    "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
    "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;

    "browser.messaging-system.whatsNewPanel.enabled" = false;

    "media.videocontrols.picture-in-picture.video-toggle.enabled" = true;

    "browser.translations.neverTranslateLanguages" = "en,de";
  };
}
