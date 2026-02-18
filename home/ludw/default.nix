/*
  home/ludw/default.nix

  created by ludw
  on 2026-02-17
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
    inputs.self.homeManagerModules.desktop-kde
    inputs.self.homeManagerModules.programs

    inputs.plasma-manager.homeModules.plasma-manager
    inputs.nixvim.homeModules.default
    inputs.zen-browser.homeModules.twilight

    ./accounts.nix
  ];
  nixpkgs = {
    # add overlays here
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages
      inputs.self.overlays.nur
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
      #GIT_ASKPASS = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
      #SSH_ASKPASS = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";

      # remove decorations for QT apps
      UBUNTU_MENUPROXY = 1;

      # set cursor size
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
