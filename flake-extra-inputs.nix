/*
  flake-extra-inputs.nix

  created by ludw
  on 2026-01-14
*/


{
  # declarative kde plasma manager
  plasma-manager = {
    url = "github:nix-community/plasma-manager";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.home-manager.follows = "home-manager";
  };

  # noctalia shell
  noctalia = {
    url = "github:noctalia-dev/noctalia-shell";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # zen browser flake
  zen-browser = {
    url = "github:0xc000022070/zen-browser-flake";
    inputs = {
      # IMPORTANT: using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply not specify the nixpkgs input
      nixpkgs.follows = "nixpkgs";
      home-manager.follows = "home-manager";
    };
  };
}
