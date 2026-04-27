/*
  modules/home/desktop/kde/default.nix

  created by ludw
  on 2026-02-26
*/

{
  pkgs,
  lib,
  ...
}:
{
  services.gpg-agent = {
    pinentry.package = lib.mkForce pkgs.kwalletcli;
    extraConfig = "pinentry-program ${pkgs.kwalletcli}/bin/pinentry-kwallet";
  };

  home.packages = with pkgs; [
    kde-rounded-corners
    kdePackages.krohnkite
  ];

  # three finger gestures
  xdg.configFile."libinput-gestures.conf".text = ''
    gesture swipe left 3 xdotool key Super+Right
    gesture swipe right 3 xdotool key Super+Left
    gesture swipe up 3 xdotool key Super+G
    gesture swipe down 3 xdotool key Super+W
  '';

  systemd.user.services.libinput-gestures = {
    Unit = {
      Description = "KDE libinput-Gestures";
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${lib.getExe libpkgs.libinput-gestures}";
      Environment = "DISPLAY=:0";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
