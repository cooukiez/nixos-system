{ pkgs, userConfig, ... }:
{
  programs.konsole = {
    enable = true;

    profiles.default = {
      name = "default";

      extraConfig = {

      };
    };
  };
}
