{
  # xserver configuration
  services.xserver = {
    enable = true;

    xkb = {
      layout = inputs.info.keymap;
      options = "eurosign:e,caps:escape";
      variant = "";
    };
  };

  # X11 utilities
  environment.systemPackages =
    (config.environment.systemPackages or [])
    ++ (with pkgs; [
      xclip
    ]);

  # remote desktop
  services.xrdp = {
    defaultWindowManager = "startplasma-x11";
    enable = true;
    openFirewall = true;
  };

  # wayland configuration
  environment.systemPackages =
    (config.environment.systemPackages or [])
    ++ (with pkgs; [
      wayland-utils
      wl-clipboard
    ]);
}