/*
  home/ceirs/default.nix

  created by ludw
  on 2026-01-25
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
      # todo: select icon theme
      QS_ICON_THEME = "Papirus-Dark";

      # wayland settings
      ELM_DISPLAY = "wl";
      CLUTTER_BACKEND = "wayland";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      # GDK_BACKEND = "wayland,x11";

      XCURSOR_SIZE = "24";
    };
  };

  # enable home-manager
  programs.home-manager.enable = true;

  # nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}
