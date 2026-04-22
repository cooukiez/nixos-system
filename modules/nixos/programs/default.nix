/*
  modules/nixos/programs/default.nix

  created by ludw
  on 2026-02-26
*/

{
  inputs,
  hostSystem,
  pkgs,
  ...
}:
{
  imports = [
    ./cli-tools.nix
    ./file-explorers.nix
    ./gaming.nix
    ./media.nix
    ./network-services.nix
    ./penetration-testing.nix
    ./services.nix
    ./web.nix
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
