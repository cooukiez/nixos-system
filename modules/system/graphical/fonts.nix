{
  config,
  pkgs,
  lib,
  hostConfig,
  ...
}:
let
  cfg = config.graphicalConfig;
in
{
  config = lib.mkIf cfg.fontsPkg {
    fonts.fontDir.enable = true;

    environment.systemPackages = with pkgs; [
      fontconfig
      fontforge
      freetype
      icu
      pango
    ];

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
      sf-compact
      sf-mono
      sf-pro
      sf-pro-nerd
      sn-pro
      steelfish-fonts
      ubuntu-sans
      ubuntu-sans-mono
      vista-fonts
      work-sans
    ];
  };
}
