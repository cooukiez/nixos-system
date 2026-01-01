# use this to configure home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # import other home-manager modules here
  imports = [
    # use modules your own flake exports (from modules/home-manager):
    # inputs.self.homeManagerModules.example

    # modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # add overlays here
    overlays = [
      # add overlays your own flake exports (from overlays and pkgs dir):
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages

      # add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # or define it inline:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # configure nixpkgs instance
    config = {
	  # allow unfree packages
      allowUnfree = true;
    };
  };

  home = {
    username = "ludw";
    homeDirectory = "/home/ludw";
  };

  # add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;

    extraConfig = {
      credential = {
        credentialStore = "secretservice";
        helper = "${pkgs.nur.repos.utybo.git-credential-manager}/bin/git-credential-manager-core";
      };
    };
  };


  # nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}
