/*
  modules/home/desktop/kde/default.nix

  created by ludw
  on 2026-02-26
*/

{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./plasma
    ./programs

    ./input-gestures.nix
    ./packages.nix
  ];

  services.gpg-agent = {
    pinentry.package = lib.mkForce pkgs.kwalletcli;
    extraConfig = "pinentry-program ${pkgs.kwalletcli}/bin/pinentry-kwallet";
  };

  home.packages = with pkgs; [
    kde-rounded-corners
    kdePackages.krohnkite
  ];
}
