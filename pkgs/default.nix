/*
  pkgs/default.nix

  created by ludw
  on 2026-02-26
*/

# custom packages

pkgs: {
  hardcode-tray = pkgs.callPackage ./hardcode-tray.nix { };
  heidisql = pkgs.callPackage ./heidisql.nix { };
  iloader = pkgs.callPackage ./iloader.nix { };
  mcmojave-cursor-theme = pkgs.callPackage ./mcmojave-cursor-theme.nix { };

  scratch-desktop = pkgs.callPackage ./scratch {
    electron = pkgs.electron_23;
  };

  steelfish-fonts = pkgs.callPackage ./steelfish-fonts.nix { };
}
