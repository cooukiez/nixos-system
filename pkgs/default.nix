/*
  pkgs/default.nix

  created by ludw
  on 2026-01-29
*/

# custom packages, that can be defined similarly to ones from nixpkgs
# build them using 'nix build .#example'
pkgs:
let
  #   appmenuGtkModule = pkgs.callPackage ./appmenu-gtk-module.nix {};

  hardcodeTray = import ./hardcode-tray.nix {
    inherit pkgs;
  };

  #   yetAnotherMonochromeIconSet = import ./yamis.nix {
  #     inherit pkgs;
  #   };

  breezeChameleonIcons = import ./breeze-chameleon.nix {
    inherit pkgs;
  };

  kdeRoundedCornersX11 = pkgs.callPackage ./kde-rounded-corners-x11.nix { };
in
{
  # example = pkgs.callPackage ./example { };
  hardcode-tray = hardcodeTray;
  breeze-chameleon-icons = breezeChameleonIcons;
  kde-rounded-corners-x11 = kdeRoundedCornersX11;

  #   appmenu-gtk-module = appmenuGtkModule;
  #   yet-another-monochrome-icon-set = yetAnotherMonochromeIconSet;
}
