/*
  modules/nixos/programs/file-explorers.nix

  created by ludw
  on 2026-01-29
*/

{
  pkgs,
  inputs,
  ...
}:
let
  # fix this and put in nautilus extensions
  _nautilusBackspaceSrc = pkgs.fetchFromGitHub {
    owner = "TheWeirdDev";
    repo = "nautilus-backspace";
    rev = "main";
    sha256 = "sha256-4x5bMIgwNIp9nxuCHWLLNvWG2zuviyEOyCZgVLRZ5W4=";
  };
in