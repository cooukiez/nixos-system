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
    hardwareCorePkg = mkEnableDefault;
    hardwareDesktopPkg = mkEnableDefault;
    mediaCorePkg = mkEnableDefault;
    mediaExtraPkg = mkEnableDefault;
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
    environment.localBinInPath = true;
    environment.enableAllTerminfo = true;

    services.dbus.enable = true;

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

    programs.zsh.enable = true;
    programs.neovim.enable = true;

    # session variables
    environment.sessionVariables = {
      VCPKG_FORCE_SYSTEM_BINARIES = 1;
      LD_LIBRARY_PATH = [ "${pkgs.zlib}/lib" ];
    };

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
    ++ (lib.optionals cfg.hardwareCorePkg network.hardwareCore)
    ++ (lib.optionals cfg.hardwareDesktopPkg network.hardwareDesktop)
    ++ (lib.optionals cfg.mediaCorePkg network.mediaCore)
    ++ (lib.optionals cfg.mediaExtraPkg network.mediaExtra)
    ++ (lib.optionals cfg.nixPkg network.nix)
    ++ (lib.optionals cfg.secretsPkg network.secrets)
    ++ (lib.optionals cfg.tuiPkg network.tui)
    ++ (lib.optionals cfg.utilsPkg network.utils);
  };
}
