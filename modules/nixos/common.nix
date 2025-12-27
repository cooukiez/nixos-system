{
  # services
  services = {
    # X11
    xserver = {
      enable = true;

      xkb = {
        layout = "de";
        options = "eurosign:e,caps:escape";
        variant = "";
      };
    };

    # remote desktop
    xrdp = {
      defaultWindowManager = "startplasma-x11";
      enable = true;
      openFirewall = true;
    };

    # firmware update services
    fwupd.enable = true;

    # openssh
    openssh = {
      enable = true;
      settings = {
        # opinionated: forbid root login through SSH
        PermitRootLogin = "no";
        # opinionated: keys and passwords
        PasswordAuthentication = true;
      };
    };

    # printing
    printing.enable = true;

    # touchpad
    libinput.enable = true;
  };
  
  # system packages
  environment.systemPackages = with pkgs; [
    # base
    vim
    wget
    git

    # wayland
    wayland-utils
    wl-clipboard

    # X11
    xclip
    
    # programs
    hardinfo2
    vlc
    mpv
    pavucontrol
    kdiff3
  ];
  
  programs.firefox.enable = true;
  programs.neovim.enable = true;

  # SUID wrappers
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}