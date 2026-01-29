/*
  overlays/default.nix

  created by ludw
  on 2026-01-01
*/

# file defines overlays

{
  inputs,
  ...
}:
{
  # this one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # see https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };

  # when applied, the unstable nixpkgs set
  # will be accessible through `pkgs.unstable`
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      localSystem = {
        system = final.stdenv.hostPlatform.system;
      };
      config.allowUnfree = true;
    };
  };
}
