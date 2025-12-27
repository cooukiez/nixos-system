# https://github.com/Misterio77/nix-starter-configs
{
  description = "system configuration for lvl";

  inputs = {
	# nixpkgs stable nixpkgs-unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # home manager
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

	# nixos profiles to optimize settings for different hardware
    hardware.url = "github:nixos/nixos-hardware";

	# declarative flatpak manager
    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=v0.6.0";

	# declarative kde plasma manager
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    # supported systems for flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
	# function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # custom packages
    # accessible through 'nix build', 'nix shell', etc.
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # formatter for your nix files, available through 'nix fmt'
    # other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    
    # reusable nixos modules you might want to export
    # these are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    
    # reusable home-manager modules you might want to export
    # these are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;

    # nixos configuration entrypoint
    # available through 'nixos-rebuild --flake .#lvl'
    nixosConfigurations = {
      lvl = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          # main config file
          ./configuration.nix
          
          self.nixosModules
        ];
      };
    };

    # standalone home-manager configuration entrypoint
    # available through 'home-manager --flake .#ludw@lvl'
    homeConfigurations = {
      "ludw@lvl" = home-manager.lib.homeManagerConfiguration {
		# home-manager requires 'pkgs' instance
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;};
        modules = [
          # main home-manager configuration
          ./home-manager/home.nix
        ];
      };
    };
  };
}