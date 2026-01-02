# custom packages, that can be defined similarly to ones from nixpkgs
# build them using 'nix build .#example'
pkgs: let
  hardcodeTray = import ./hardcode-tray.nix {
    inherit pkgs;
    stdenv = pkgs.stdenv;
    fetchFromGitHub = pkgs.fetchFromGitHub;
    meson = pkgs.meson;
    ninja = pkgs.ninja;
    pkg-config = pkgs.pkg-config;
    python3 = pkgs.python3;
    python3Packages = pkgs.python3Packages;
    gtk3 = pkgs.gtk3;
    librsvg = pkgs.librsvg;
    inkscape = pkgs.inkscape;
    imagemagick = pkgs.imagemagick;
  };
in {
  # example = pkgs.callPackage ./example { };
  hardcode-tray = hardcodeTray;
}
