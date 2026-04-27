{
  config,
  userConfig,
  ...
}:
let
  packages = import ./programs/packages.nix { inherit pkgs; };
in
{
  imports = [
    ./desktop/kde
    ./desktop/nn

    ./programs/common
    ./programs/web
  ];

  options.desktop = {
    kde = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    nn = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = {
    desktop = {
      kde = lib.mkIf (userConfig.session == "kde") true;
      nn = lib.mkIf (userConfig.session == "nn") true;
    };

    environment.systemPackages =
      lib.optionals config.desktop.nn (packages.nn ++ packages.gnome)
      ++ lib.optionals config.desktop.kde (packages.kde);
  };
}
