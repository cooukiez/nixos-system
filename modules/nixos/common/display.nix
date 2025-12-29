{ pkgs, info, ... }: {
  # xserver configuration
  services.xserver = {
    enable = true;

    xkb = {
      layout = info.keymap;
      options = "eurosign:e,caps:escape";
      variant = "";
    };
  };

  # remote desktop
  services.xrdp = {
    defaultWindowManager = "startplasma-x11";
    enable = true;
    openFirewall = true;
  };

  # required system packages
  environment.systemPackages = with pkgs; [
    # X11 utilities
    xclip
  
    # wayland utilities
    wayland-utils
    wl-clipboard
  ];
}