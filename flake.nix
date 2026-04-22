/*
  flake.nix

  created by ludw
  on 2026-02-26
*/

{
  description = "nixos system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    wrappers.url = "github:lassulus/wrappers";
    agenix.url = "github:ryantm/agenix";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    gamemaker.url = "github:cooukiez/gamemaker-flake";
    honklet.url = "github:hannahfluch/honklet";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib;

      hostDirs = lib.attrNames (
        lib.filterAttrs (name: type: type == "directory") (builtins.readDir ./hosts)
      );

      mkHost =
        hostName:
        let
          hostPath = ./hosts/${hostName};
          hostData = import "${hostPath}/default.nix";
          hostConfig = import "${hostPath}/host.nix";
          userList = import "${hostPath}/users.nix";
        in
        lib.nixosSystem {
          system = hostConfig.hostSystem;
          specialArgs = {
            inherit
              inputs
              outputs
              hostConfig
              userList
              ;
            inherit (hostConfig) hostname;
          };

          modules = [
            hostPath

            ({ system.stateVersion = "25.11"; })
          ];
        };

      supportedSystems = [
        "x86_64-linux"
      ];

      forAllSystems = lib.genAttrs supportedSystems;
    in
    {
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

      overlays = {
        inherit (import ./overlays { inherit inputs; })
          additions
          modifications
          unstable-packages
          ;
      };

      systemModules = import ./modules/system;
      homeModules = import ./modules/home;

      nixosConfigurations = lib.genAttrs hostDirs (name: mkHost name);
    };
}
