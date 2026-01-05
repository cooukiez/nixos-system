{ pkgs, userConfig, ... }:
{
  programs.thunderbird = {
    enable = true;
    package = pkgs.unstable.thunderbird;

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      settings = {

      };
    };
  };
}
