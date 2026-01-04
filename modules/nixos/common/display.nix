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
  ];

  # enable wayland support in chromium and electron based applications
  # remove decorations for QT apps
  # set cursor size
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XCURSOR_SIZE = "24";
  };
}
