/*
  modules/system/network/packages.nix

  part of nixos system
  created 2026-04-22
*/

{
  pkgs,
  ...
}:
{
  core = with pkgs; [
    apacheHttpd
    aria2
    dig
    httpie
    inetutils
    mtr
    ngrok
    speedtest-cli
  ];

  tui = with pkgs; [
    bandwhich
    gping
    nethogs
  ];
}
