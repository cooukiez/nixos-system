{
  config,
  userConfig,
  ...
}:
{
  imports = [
    ./kde
    ./nn
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

  };
}
