# custom packages, that can be defined similarly to ones from nixpkgs
# build them using 'nix build .#example'
pkgs: let
  hardcodeTray = import ./hardcode-tray.nix {
    inherit pkgs;
  };

  libdbusmenuQt4 = import ./libdbusmenu-qt4.nix {
    inherit pkgs;
  };
in {
  # example = pkgs.callPackage ./example { };
  hardcode-tray = hardcodeTray;
  libdbusmenu-qt4 = libdbusmenuQt4;
}
