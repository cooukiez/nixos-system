/*
  flake.nix

  created by ludw
  on 2026-02-26
*/

{
  description = "system configuration for my laptop";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.home-manager.follows = "home-manager";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:ryantm/agenix";
    copyparty.url = "github:9001/copyparty";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    gamemaker.url = "github:cooukiez/gamemaker-flake";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    honklet.url = "github:hannahfluch/honklet";
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

      # set local subnet static IP
      staticIP = "192.168.178.24";

      dnsServers = [
        "1.1.1.1"
        "8.8.8.8"
        "9.9.9.9"
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
              staticIP
              dnsServers
              users
              ;
            nixosModules = "${self}/modules/nixos";
          };
          modules = [
            # main config file
            ./configuration.nix

            inputs.hardware.nixosModules.lenovo-thinkpad-x1-yoga-8th-gen
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
              hostname
              staticIP
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
