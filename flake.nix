# https://github.com/Misterio77/nix-starter-configs
# https://github.com/AlexNabokikh/nix-config
{
  description = "system configuration for my laptop.";

  inputs = let
    extraInputs = import ./flake-extra-inputs.nix;
  in
  {
    # nixpkgs stable nixpkgs-unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # nixos profiles to optimize settings for different hardware
    hardware.url = "github:nixos/nixos-hardware";

    # declarative flatpak manager
    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=v0.6.0";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home manager
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    inherit (extraInputs) plasma-manager noctalia zen-browser;
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

      # define user configurations
      users = {
        ludw = {
          email = "ludwig.geyer@mailbox.org";
          fullName = "Ludwig";
          githubName = "cooukiez";
          githubEmail = "ludwig-geyer@web.de";
          name = "ludw";
        };

        ceirs = {
          email = "ludwig.geyer@mailbox.org";
          fullName = "Ceirs";
          githubName = "cooukiez";
          githubEmail = "ludwig-geyer@web.de";
          name = "ceirs";
        };
      };

      # supported systems for flake packages, shell, etc.
      lvlSystem = "x86_64-linux";
      systems = [
        lvlSystem
      ];
      # function that generates an attribute by calling a function you
      # pass to it, with each system as an argument
      forAllSystems = nixpkgs.lib.genAttrs systems;

      mkNixosConfiguration =
        hostname:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs hostname users;
            nixosModules = "${self}/modules/nixos";
          };
          modules = [
            # main config file
            ./configuration.nix
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
            inherit inputs outputs;
            userConfig = users.${username};
            nhModules = "${self}/modules/home-manager";
          };
          modules = [
            ./home/${username}
            inputs.plasma-manager.homeModules.plasma-manager
          ];
        };
    in
    {
      # custom packages
      # accessible through 'nix build', 'nix shell', etc.
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      # formatter for your nix files, available through 'nix fmt'
      # other options beside 'alejandra' include 'nixpkgs-fmt'
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

      # your custom packages and modifications, exported as overlays
      overlays = {
        inherit (import ./overlays { inherit inputs; })
          additions
          modifications
          unstable-packages
          ;

        nur = inputs.nur.overlays.default;
      };

      # reusable nixos modules you might want to export
      # these are usually stuff you would upstream into nixpkgs
      nixosModules = import ./modules/nixos;

      # reusable home-manager modules you might want to export
      # these are usually stuff you would upstream into home-manager
      homeManagerModules = import ./modules/home-manager;

      # nixos configuration entrypoint
      # available through 'nixos-rebuild --flake .#lvl'
      nixosConfigurations = {
        lvl = mkNixosConfiguration "lvl";
      };

      # standalone home-manager configuration entrypoint
      # available through 'home-manager --flake .#ludw@lvl'
      homeConfigurations = {
        "ludw@lvl" = mkHomeConfiguration lvlSystem "ludw" "lvl";
        "ceirs@lvl" = mkHomeConfiguration lvlSystem "ceirs" "lvl";
      };
    };
}
