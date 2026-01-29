/*
  modules/home/desktop/kde/default.nix

  created by ludw
  on 2026-01-29
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

  # set gpg agent specific to kwallet
  services.gpg-agent = {
    pinentry.package = lib.mkForce pkgs.kwalletcli;
    extraConfig = "pinentry-program ${pkgs.kwalletcli}/bin/pinentry-kwallet";
  };

  # kde internal packages
  home.packages = with pkgs; [
    # get rounded corners for windows (only wayland)
    kde-rounded-corners
    # tiling window manager
    kdePackages.krohnkite
  ];
}
