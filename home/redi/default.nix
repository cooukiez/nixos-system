/*
  home/redi/default.nix

  created by ludw
  on 2026-02-16
*/

# configure home environment

{
  inputs,
  lib,
  config,
  userConfig,
  pkgs,
  ...
}:
let
  info = import ../info.nix;
in
{
  # import home-manager modules here
  imports = [
    inputs.self.homeManagerModules.desktop-nn
    inputs.self.homeManagerModules.programs

    inputs.niri.homeModules.niri
    inputs.noctalia.homeModules.default
    inputs.stylix.homeModules.stylix
    inputs.nixvim.homeModules.default
    inputs.zen-browser.homeModules.twilight
  ];
  nixpkgs = {
    # add overlays here
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages
      inputs.self.overlays.nur

      inputs.niri.overlays.niri

      (self: super: {
        gnome = super.gnome.overrideScope (
          gself: gsuper: {
            nautilus = gsuper.nautilus.overrideAttrs (nsuper: {
              buildInputs =
                nsuper.buildInputs
                ++ (with super.gst_all_1; [
                  gst-plugins-good
                  gst-plugins-bad
                ]);
            });
          }
        );
      })
    ];

    # configure nixpkgs instance
    config = {
      # allow unfree packages
      allowUnfree = true;
      permittedInsecurePackages = [
        "dotnet-sdk-6.0.428"
        "dotnet-runtime-6.0.36"
      ];
    };
  };

  home = {
    username = "${userConfig.name}";
    homeDirectory = "/home/${userConfig.name}";
    sessionVariables = {
      # qt settings
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_ENABLE_HIGHDPI_SCALING = "1";
      QT_SCALE_FACTOR_ROUNDING_POLICY = "PassThrough";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QS_ICON_THEME = "Papirus-Dark";

      # wayland settings
      ELM_DISPLAY = "wl";
      CLUTTER_BACKEND = "wayland";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      ELECTRON_PASSWORD_STORE = "gnome-libsecret";
      # GDK_BACKEND = "wayland,x11";

      # enable wayland support in chromium and electron based applications
      NIXOS_OZONE_WL = "1";

      # pretend desktop is gnome
      XDG_CURRENT_DESKTOP = "GNOME";

      XCURSOR_SIZE = "24";

      # smoother scrolling for firefox
      MOZ_USE_XINPUT2 = "1";

      _JAVA_OPTIONS = "-Dawt.toolkit.name=WLToolkit -Dide.linux.hide.native.title.bar=true";
    };
  };

  accounts.email.accounts = {
    ludwig = {
      enable = true;
      primary = true;
      address = "ludwig@redi-school.org";
      userName = "ludwig@redi-school.org";

      /*
        imap = {
          host = "imap.gmail.com";
          port = 993;
          tls.enable = true;
        };

        smtp = {
          host = "smtp.gmail.com";
          port = 587;
          tls = {
            enable = true;
            useStartTls = true;
          };
        };
      */

      # name = "ludwig";
      realName = "Ludwig";

      thunderbird.enable = true;
      thunderbird.profiles = [ "default" ];
    };

    kids = {
      enable = true;
      address = "kids@redi-school.org";
      userName = "kids@redi-school.org";

      /*
        imap = {
          host = "imap.gmail.com";
          port = 993;
          tls.enable = true;
        };

        smtp = {
          host = "smtp.gmail.com";
          port = 587;
          tls = {
            enable = true;
            useStartTls = true;
          };
        };
      */

      # name = "kids";
      realName = "Kids";

      thunderbird.enable = true;
      thunderbird.profiles = [ "default" ];
    };

    cookiecenter = {
      enable = true;
      address = "cookiecenter@web.de";
      userName = "cookiecenter@web.de";

      imap = {
        host = "imap.web.de";
        port = 993;
        tls.enable = true;
      };

      smtp = {
        host = "smtp.web.de";
        port = 587;
        tls = {
          enable = true;
          useStartTls = true;
        };
      };

      # name = "cookiecenter";
      realName = "Web Account";

      thunderbird.enable = true;
      thunderbird.profiles = [ "default" ];
    };
  };

  # enable home-manager
  programs.home-manager.enable = true;

  # nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}
