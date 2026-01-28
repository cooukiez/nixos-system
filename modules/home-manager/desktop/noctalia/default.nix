{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./noctalia

    ./niri.nix
    ./packages.nix
    ./style.nix
    ./xdg-config.nix
  ];

  services.gnome-keyring = {
    enable = true;
    components = [
      "pkcs11"
      "secrets"
      "ssh"
    ];
  };

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

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
  };
}
