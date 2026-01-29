/*
  modules/home-manager/desktop/noctalia/dconf.nix

  created by ludw
  on 2026-01-26
*/


{
  dconf.settings = {
    # probably not required an already set by stylix
    "org/gnome/desktop/interface" = {
      color-scheme = lib.mkForce "prefer-dark";
    };
    # remove all window buttons
    "org/gnome/desktop/wm/preferences" = {
      button-layout = lib.mkForce ":";
    };
    # set nautilus terminal
    "com/github/stunkymonkey/nautilus-open-any-terminal" = {
      terminal = "kitty";
    };
  };
}
