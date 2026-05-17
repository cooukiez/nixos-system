/*
overlays/default.nix

part of nixos system
created 2026-02-26 by ludw
*/
{
  inputs,
  system,
  ...
}: {
  additions = final: _prev: import ../pkgs final.pkgs;

  modifications = final: prev: {
    agenix = inputs.agenix.packages.${system}.default;

    noctalia = inputs.noctalia.packages.${system}.default;

    sf-compact = inputs.apple-fonts.packages.${system}.sf-compact;
    sf-mono = inputs.apple-fonts.packages.${system}.sf-mono;
    sf-pro = inputs.apple-fonts.packages.${system}.sf-pro;
    sf-pro-nerd = inputs.apple-fonts.packages.${system}.sf-pro-nerd;

    gamemaker = inputs.gamemaker.packages.${system}.default;
    zed-latest = inputs.zed.packages.${system}.default;
    zen-browser = inputs.zen-browser.packages.${system}.twilight;

    # portable web apps
    asana-pwa = inputs.asana-pwa.packages.${system}.default;
    gemini-pwa = inputs.gemini-pwa.packages.${system}.default;
    typst-pwa = inputs.typst-pwa.packages.${system}.default;
    whatsapp-pwa = inputs.whatsapp-pwa.packages.${system}.default;

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
