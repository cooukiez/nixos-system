# custom packages, that can be defined similarly to ones from nixpkgs
# build them using 'nix build .#example'
pkgs: let
  hardcodeTray = import ./hardcode-tray.nix {
    inherit pkgs;
  };

  yetAnotherMonochromeIconSet = import ./yet-another-monochrome-icon-set.nix {
    inherit pkgs;
  };
in {
  # example = pkgs.callPackage ./example { };
  hardcode-tray = hardcodeTray;
  yet-another-monochrome-icon-set = yetAnotherMonochromeIconSet;
}
