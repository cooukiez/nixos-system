# custom packages, that can be defined similarly to ones from nixpkgs
# build them using 'nix build .#example'
pkgs:
let
  hardcodeTray = import ./hardcode-tray.nix {
    inherit pkgs;
  };

  #   yetAnotherMonochromeIconSet = import ./yamis.nix {
  #     inherit pkgs;
  #   };

  breezeChameleonIcons = import ./breeze-chameleon {
    inherit pkgs;
  };
in
{
  # example = pkgs.callPackage ./example { };
  hardcode-tray = hardcodeTray;
  breeze-chameleon-icons = breezeChameleonIcons;

  #   yet-another-monochrome-icon-set = yetAnotherMonochromeIconSet;
}
