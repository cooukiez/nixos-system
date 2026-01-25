{ pkgs, userConfig, ... }:
{
  programs.zathura.enable = true;

  programs.zathura.options = {
    selection = "clipboard";
  };
}
