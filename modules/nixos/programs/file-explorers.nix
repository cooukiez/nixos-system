/*
  modules/nixos/programs/file-explorers.nix

  created by ludw
  on 2026-02-17
*/

{
  pkgs,
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
{
  environment.systemPackages = with pkgs; [
    # nautilus from gnome
    nautilus
    nautilus-python
    nautilus-open-any-terminal
    code-nautilus
  ];

  # thunar file manager
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
      thunar-vcs-plugin
      thunar-dropbox-plugin
      thunar-media-tags-plugin
    ];
  };
}
