/*
  modules/nixos/common/display.nix

  created by ludw
  on 2026-02-23
*/

{
  inputs,
  pkgs,
  hostSystem,
  ...
}:
{
  # xserver / x11 configuration
  services.xserver = {
    enable = true;
    xkb = {
      layout = "de";
      options = "eurosign:e,caps:escape";
      variant = "";
    };
    excludePackages = with pkgs; [ xterm ];
  };

  # wayland configuration
  programs.xwayland.enable = true;

  # system packages
  environment.systemPackages = with pkgs; [
    # wayland utilities
    wayland-utils
    wlinhibit
  ];

  # fonts configuration
  fonts.packages = with pkgs; [
    arcticons-sans
    aurulent-sans
    corefonts
    dejavu_fonts
    encode-sans
    fira
    fira-sans
    font-awesome
    garamond-libre
    go-font
    googlesans-code
    inputs.apple-fonts.packages.${hostSystem}.sf-compact
    inputs.apple-fonts.packages.${hostSystem}.sf-mono
    inputs.apple-fonts.packages.${hostSystem}.sf-pro
    inputs.apple-fonts.packages.${hostSystem}.sf-pro-nerd
    inter
    liberation_ttf
    libertinus
    manrope
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    notonoto
    open-sans
    poppins
    roboto
    roboto-flex
    roboto-serif
    rubik
    sn-pro
    steelfish-fonts
    ubuntu-sans
    ubuntu-sans-mono
    vista-fonts
    work-sans
  ];

  fonts.fontDir.enable = true;
}
