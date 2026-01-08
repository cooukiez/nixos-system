{ pkgs, userConfig, ... }:
{
  programs.konsole = {
    enable = true;

    profiles.default = {
      name = "default";

      extraConfig = {
        General = {
          TerminalMargin = 7;
        };
      };
    };
  };
}
