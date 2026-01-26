{ config, pkgs, ... }:
let
  # read all files in the current directory
  files = builtins.readDir ./.;

  # filter out default.nix and non nix files
  nixFiles = builtins.filter (name: name != "default.nix" && builtins.match ".*\\.nix" name != null) (
    builtins.attrNames files
  );

  # create a list of import statements
  fileImports = map (name: ./. + "/${name}") nixFiles;
in
{
  programs.nixvim = {
    enable = true;
    version.enableNixpkgsReleaseCheck = false;

    imports = fileImports;

    colorschemes.onedark.enable = true;
  };
}
