{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.graphicalPrograms.firefox;

  baseArgs = [
    "--ozone-platform-hint=auto"
    "--disable-vulkan"
  ];

  kdeArgs = [ "--password-store=kwallet6" ];
  nnArgs = [ "--password-store=gnome-libsecret" ];
in
{
  config = lib.mkIf cfg {
    home.packages = [
      (pkgs.element-desktop.override {
        commandLineArgs =
          baseArgs ++ lib.optionals config.desktop.kde kdeArgs ++ lib.optionals config.desktop.nn nnArgs;
      })
    ];
  };
}
