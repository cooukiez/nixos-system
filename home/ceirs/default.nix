# use this to configure home environment (it replaces ~/.config/nixpkgs/home.nix)
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
  # import other home-manager modules here
  imports = [
    # use modules your own flake exports (from modules/home-manager):
    # inputs.self.homeManagerModules.example

    # modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # also split up your configuration and import pieces of it here:
    # ./nvim.nix

    inputs.self.homeManagerModules.desktop-noctalia
    inputs.self.homeManagerModules.programs

    inputs.zen-browser.homeModules.twilight
  ];

  nixpkgs = {
    # add overlays here
    overlays = [
      # add overlays your own flake exports (from overlays and pkgs dir):
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages
      inputs.self.overlays.nur

      # add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      (self: super: {
        gnome = super.gnome.overrideScope' (gself: gsuper: {
          nautilus = gsuper.nautilus.overrideAttrs (nsuper: {
            # Use super.gst_all_1 here to pull it from the package set
            buildInputs = nsuper.buildInputs ++ (with super.gst_all_1; [
              gst-plugins-good
              gst-plugins-bad
            ]);
          });
        });
      })

      # or define it inline:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # configure your nixpkgs instance
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
      # START_NOCTALIA = "true";
    };
  };

  # add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # enable home-manager
  programs.home-manager.enable = true;

  # enable hyprland
  wayland.windowManager.hyprland.enable = true;

  # nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}
