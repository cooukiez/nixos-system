{ config, pkgs, ... }:
{
  programs.nixvim = {
    enable = true;

    colorschemes.onedark.enable = true;
  };
}
