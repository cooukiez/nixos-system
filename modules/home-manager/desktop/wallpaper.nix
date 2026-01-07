{ lib, ... }:
{
  options.wallpaper = lib.mkOption {
    type = lib.types.path;
    default = file:///etc/nixos/files/piazza-gae-aulenti-bw-edited.jpg;
    readOnly = true;
    description = "Path to default wallpaper";
  };
}
