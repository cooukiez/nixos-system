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
    inkscape

    # appearance
    papirus-icon-theme
    hardcode-tray
  ];

  # enable programs here
  programs.firefox.enable = true;
  programs.neovim.enable = true;
}
