/*
flake.nix

part of nixos system
created 2026-06-16 by ludw
*/
{
  description = "nixos system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wrappers.url = "github:cooukiez/wrappers";
    agenix.url = "github:ryantm/agenix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # flake-utils
    flake-utils.url = "github:numtide/flake-utils";

    firefox-addons = {
      url = "github:petrkozorezov/firefox-addons-nix";
      inputs.flake-utils.follows = "flake-utils";
    };

    # apple-fonts.url = "github:Lyndeno/apple-fonts.nix/update/flake-update";

    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    copyparty.url = "github:9001/copyparty";
    gamemaker.url = "github:cooukiez/gamemaker-flake";
    obsidian-plugins.url = "github:vomba/obsidian-plugins-nix";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    zed.url = "github:zed-industries/zed";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    # portable web apps
    asana-pwa.url = "github:ceirs-nix-system/asana-pwa";
    gemini-pwa.url = "github:ceirs-nix-system/gemini-pwa";
    typst-pwa.url = "github:ceirs-nix-system/typst-pwa";
    whatsapp-pwa.url = "github:ceirs-nix-system/whatsapp-pwa";

    # useless
    honklet.url = "github:hannahfluch/honklet";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib;

    hostDirs = lib.attrNames (
      lib.filterAttrs (name: type: type == "directory") (builtins.readDir ./hosts)
    );

    mkHost = hostName: let
      hostPath = ./hosts/${hostName};
      hostConfig = import "${hostPath}/host.nix";
      allUsers = import ./users.nix;

      selectedUsers = lib.filterAttrs (username: _: lib.elem username (hostConfig.users or [])) allUsers;
    in
      lib.nixosSystem {
        system = hostConfig.hostSystem;
        specialArgs = {
          inherit
            inputs
            outputs
            hostConfig
            ;

          userList = selectedUsers;
          inherit (hostConfig) hostname;
        };

        modules = [
          hostPath

          {system.stateVersion = "26.05";}
        ];
      };

    system = "x86_64-linux";
    supportedSystems = [system];

    forAllSystems = lib.genAttrs supportedSystems;
  in {
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    overlays = {
      inherit
        (import ./overlays {inherit inputs system;})
        additions
        modifications
        ;
    };

    systemModules = import ./modules/system;
    homeModules = import ./modules/home;

    nixosConfigurations = lib.genAttrs hostDirs (name: mkHost name);
  };
}
