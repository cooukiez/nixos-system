/*
  modules/home/desktop/nn/default.nix

  created by ludw
  on 2026-02-16
*/

{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./niri
    ./noctalia
    ./programs

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
    # required to force setting and overwrite multiple others
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

  services.kanshi = {
    enable = true;
    settings = [
      /*
        {
          profile = {
            name = "mobile_4k";
            outputs = [
              {
                criteria = "eDP-1";
                mode = "3840x2160";
                scale = 2.0;
              }
            ];
            exec = [ "${pkgs.bash}/bin/bash -c \"echo 'Xft.dpi: 192' | ${pkgs.xorg.xrdb}/bin/xrdb -merge\"" ];
          };
        }
      */
      /*
        {
          profile = {
            name = "mobile_1080p";
            outputs = [
              {
                criteria = "eDP-1";
                mode = "1920x1080";
                scale = 1.0;
              }
            ];
            exec = [ "${pkgs.bash}/bin/bash -c \"echo 'Xft.dpi: 96' | ${pkgs.xorg.xrdb}/bin/xrdb -merge\"" ];
          };
        }
      */
    ];
  };
}
