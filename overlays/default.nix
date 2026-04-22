/*
  overlays/default.nix

  created by ludw
  on 2026-02-26
*/

{
  inputs,
  ...
}:
{
  additions = final: _prev: import ../pkgs final.pkgs;
  modifications = final: prev: { };

  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      localSystem = {
        system = final.stdenv.hostPlatform.system;
      };

      config.allowUnfree = true;
    };
  };
}
