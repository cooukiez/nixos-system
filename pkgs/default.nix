# custom packages, that can be defined similarly to ones from nixpkgs
# build them using 'nix build .#example'
pkgs: let
  hardcodeTray = import ./hardcode-tray.nix {
    inherit pkgs;
  };

  appmenuGtkModule = import ./appmenu-gtk-module.nix {
    inherit pkgs;
  };
in {
  # example = pkgs.callPackage ./example { };
  hardcode-tray = hardcodeTray;
  appmenu-gtk-module = appmenuGtkModule;
}
