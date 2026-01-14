{ pkgs, ... }:
{
  # xserver configuration
  services.xserver = {
    enable = true;

    xkb = {
      layout = "de";
      options = "eurosign:e,caps:escape";
      variant = "";
    };

    excludePackages = with pkgs; [ xterm ];
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };

    icons.enable = true;
  };

  # wayland configuration
  programs.xwayland.enable = true;

  # remote desktop
  services.xrdp = {
    # plasma is only wm with x11 support
    defaultWindowManager = "startplasma-x11";
    enable = true;
    openFirewall = true;
  };

  # common container config
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # required system packages
  environment.systemPackages = with pkgs; [
    # X11 utilities
    xclip

    # wayland utilities
    wayland-utils
    wl-clipboard
    cliphist # wayland clipboard history manager
  ];
}
