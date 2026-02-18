/*
  flake.nix

  created by ludw
  on 2026-02-17
*/

# start config from https://github.com/Misterio77/nix-starter-configs
# inspired by https://github.com/AlexNabokikh/nix-config

{
  description = "system configuration for my laptop";

  inputs = {
    # nixpkgs stable nixpkgs-unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # nixos profiles to optimize settings for different hardware
    hardware.url = "github:nixos/nixos-hardware";

    # declarative flatpak manager
    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=v0.6.0";

    nix-snapd = {
      url = "github:nix-community/nix-snapd";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # niri, scrolling wayland compositor
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # home-manager / stylix, configure application style
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # home-manager / declarative kde plasma manager
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.home-manager.follows = "home-manager";
    };

    # home-manager / noctalia shell, written in quickshell
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # home-manager / nixos vim config with nixvim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # zen browser flake
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        # IMPORTANT: using "libgbm" and is only available in unstable so ensure
        # to have it up-to-date or simply not specify the nixpkgs input
        nixpkgs.follows = "nixpkgs-unstable";
        home-manager.follows = "home-manager";
      };
    };

    copyparty.url = "github:9001/copyparty";
    agenix.url = "github:ryantm/agenix";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    gamemaker.url = "github:skirlez/gamemaker-flake";

    honklet = {
      url = "github:hannahfluch/honklet";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      # define user configuration
      users = import ./user-configuration.nix;

      # supported systems for flake packages, shell, etc.
      hostSystem = "x86_64-linux";
      systems = [
        hostSystem
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;

      mkNixosConfiguration =
        hostname:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit
              inputs
              outputs
              hostSystem
              hostname
              users
              ;
            nixosModules = "${self}/modules/nixos";
          };
          modules = [
            # main config file
            ./configuration.nix

            inputs.hardware.nixosModules.lenovo-thinkpad-x1-yoga
          ];
        };

      mkHomeConfiguration =
        system: username: hostname:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            localSystem = {
              inherit system;
            };
          };

          extraSpecialArgs = {
            inherit
              inputs
              outputs
              hostSystem
              ;
            userConfig = users.${username};
            nhModules = "${self}/modules/home";
          };
          modules = [
            ./home/${username}
          ];
        };
    in
    {
      # custom packages
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      # formatter for your nix files
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

      # custom packages and modifications, exported as overlays
      overlays = {
        inherit (import ./overlays { inherit inputs; })
          additions
          modifications
          unstable-packages
          ;

        nur = inputs.nur.overlays.default;
      };

      # nixos system modules
      nixosModules = import ./modules/nixos;

      # home-manager modules
      homeManagerModules = import ./modules/home;

      # nixos configuration entrypoint
      nixosConfigurations = {
        lvl = mkNixosConfiguration "lvl";
      };

      # standalone home-manager configuration entrypoint
      homeConfigurations = {
        "ceirs@lvl" = mkHomeConfiguration hostSystem "ceirs" "lvl";
        "ludw@lvl" = mkHomeConfiguration hostSystem "ludw" "lvl";
        "redi@lvl" = mkHomeConfiguration hostSystem "redi" "lvl";
      };
    };
}
