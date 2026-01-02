{ pkgs, ... }:
{
  # SUID wrappers
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  environment.systemPackages = with pkgs; [
    hardinfo2
    vlc
    mpv
    pavucontrol
    gimp2-with-plugins
    krita
    inkscape

    # appearance
    papirus-icon-theme
    tela-icon-theme
    tela-circle-icon-theme
    tango-icon-theme
    reversal-icon-theme
    qogir-icon-theme
    numix-icon-theme
    numix-icon-theme-circle
    numix-icon-theme-square
    yet-another-monochrome-icon-set
    hardcode-tray
  ];

  # enable programs here
  programs.firefox.enable = true;
  programs.neovim.enable = true;
}
