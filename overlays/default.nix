/*
  overlays/default.nix

  created by ludw
  on 2026-02-26
*/

{
  inputs,
  system,
  ...
}:
{
  additions = final: _prev: import ../pkgs final.pkgs;

  modifications = final: prev: {
    agenix = inputs.agenix.packages.${system}.default;

    noctalia = inputs.noctalia.packages.${system}.default.override {
      calendarSupport = true;
    };

    sf-compact = inputs.apple-fonts.packages.${system}.sf-compact;
    sf-mono = inputs.apple-fonts.packages.${system}.sf-mono;
    sf-pro = inputs.apple-fonts.packages.${system}.sf-pro;
    sf-pro-nerd = inputs.apple-fonts.packages.${system}.sf-pro-nerd;

    gamemaker = inputs.gamemaker.packages.${system}.default;
    zen-browser = inputs.zen-browser.packages.${system}.twilight;

    # useless
    honklet = inputs.honklet.packages.${system}.default;
  };

  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      localSystem = {
        system = final.stdenv.hostPlatform.system;
      };

      config.allowUnfree = true;
    };
  };
}
