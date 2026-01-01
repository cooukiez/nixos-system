{ pkgs, ... }: {
  # SUID wrappers
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # programs in pkgs
  environment.systemPackages = with pkgs; [
		hardinfo2
		vlc
		mpv
		pavucontrol
		kdiff3
  ];
  
  # enable programs here
  programs.firefox.enable = true;
  programs.neovim.enable = true;
}
