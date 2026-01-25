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

  /*
    services.logind = {
      enable = true;
      idleAction = "suspend";
      idleActionSec = "15m";
    };
  */

  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };

    icons.enable = true;
  };

  # wayland configuration
  programs.xwayland.enable = true;

  # required system packages
  environment.systemPackages = with pkgs; [
    # X11 utilities
    xclip

    # wayland utilities
    wayland-utils
    wl-clipboard
    cliphist # wayland clipboard history manager
    wf-recorder
    wlinhibit
    grim
    slurp
  ];
}
