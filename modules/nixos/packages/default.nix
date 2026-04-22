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
  options.packageConfig = {
    corePkg = mkEnableDefault;
    devPkg = mkEnableDefault;
    filesystemPkg = mkEnableDefault;
    hardwarePkg = mkEnableDefault;
    mediaPkg = mkEnableDefault;
    nixPkg = mkEnableDefault;
    penetrationPkg = mkEnableDefault;
    secretsPkg = mkEnableDefault;
    tuiPkg = mkEnableDefault;
    utilsPkg = mkEnableDefault;

    uselessPkg = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = {
    programs.nix-ld.enable = true;
    programs.nh = {
      enable = true;
      flake = "/etc/nixos";

      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
    };

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    programs.neovim.enable = true;

    # todo: move this
    # location services
    services.locate.enable = true;
    # enable firmware update services
    services.fwupd.enable = true;
    # enable devmon for device management
    services.devmon.enable = true;
    # network statistics
    services.vnstat.enable = true;

    environment.systemPackages = [
      clear-logs
      cp-fonts
      del-snaps
      edit-secret
      fix-perms
      snaps-du
    ]
    ++ (lib.optionals cfg.corePkg network.core)
    ++ (lib.optionals cfg.devPkg network.dev)
    ++ (lib.optionals cfg.filesystemPkg network.filesystem)
    ++ (lib.optionals cfg.hardwarePkg network.hardware)
    ++ (lib.optionals cfg.mediaPkg network.media)
    ++ (lib.optionals cfg.nixPkg network.nix)
    ++ (lib.optionals cfg.secretsPkg network.secrets)
    ++ (lib.optionals cfg.tuiPkg network.tui)
    ++ (lib.optionals cfg.utilsPkg network.utils);
  };
}
