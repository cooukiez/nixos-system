{
  inputs,
  hostSystem,
  ...
}:
let
  packages = import ./packages.nix { inherit pkgs; };
  cfg = config.packageConfig;

  clear-logs = pkgs.writeShellScriptBin "clear-logs" (builtins.readFile ./scripts/clear-logs.sh);
  cp-fonts = pkgs.writeShellScriptBin "cp-fonts" (builtins.readFile ./scripts/cp-fonts.sh);
  del-snaps = pkgs.writeShellScriptBin "del-snaps" (builtins.readFile ./scripts/del-snaps.sh);
  edit-secret = pkgs.writeShellScriptBin "edit-secret" (builtins.readFile ./scripts/edit-secret.sh);
  fix-perms = pkgs.writeShellScriptBin "fix-perms" (builtins.readFile ./scripts/fix-perms.sh);
  snaps-du = pkgs.writeShellScriptBin "snaps-du" (builtins.readFile ./scripts/snaps-du.sh);

  mkEnableDefault = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };
in
{
  options.graphicalConfig = {
    corePkg = mkEnableDefault;
    qtPkg = mkEnableDefault;
    appmenuPkg = mkEnableDefault;
    compatibilityPkg = mkEnableDefault;

    gnomeSupport = mkEnableDefault;
  };

  config = {
    environment.systemPackages = [
      clear-logs
      cp-fonts
      del-snaps
      edit-secret
      fix-perms
      snaps-du
    ];

  };
}
