{
  config,
  pkgs,
  lib,
  hostConfig,
  ...
}:
let
  packages = import ./packages.nix { inherit pkgs hostConfig; };
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
  imports = [
    ./programs/nvim
    ./programs/git.nix
    ./programs/zsh.nix
  ];

  options.packageConfig = {
    corePkg = mkEnableDefault;
    nixPkg = mkEnableDefault;
    secretsPkg = mkEnableDefault;
    utilsPkg = mkEnableDefault;

    devPkg = mkEnableDefault;
    filesystemPkg = mkEnableDefault;

    hardwareCorePkg = mkEnableDefault;
    hardwareDesktopPkg = mkEnableDefault;

    mediaCorePkg = mkEnableDefault;
    mediaExtraPkg = mkEnableDefault;

    uselessPkg = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    penetrationPkg = mkEnableDefault;
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

    programs.neovim.enable = true;

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
    ++ (lib.optionals cfg.corePkg packages.core)
    ++ (lib.optionals cfg.nixPkg packages.nix)
    ++ (lib.optionals cfg.secretsPkg packages.secrets)
    ++ (lib.optionals cfg.utilsPkg packages.utils)

    ++ (lib.optionals cfg.devPkg packages.dev)
    ++ (lib.optionals cfg.filesystemPkg packages.filesystem)

    ++ (lib.optionals cfg.hardwareCorePkg packages.hardwareCore)
    ++ (lib.optionals cfg.hardwareDesktopPkg packages.hardwareDesktop)

    ++ (lib.optionals cfg.mediaCorePkg packages.mediaCore)
    ++ (lib.optionals cfg.mediaExtraPkg packages.mediaExtra)

    ++ (lib.optionals cfg.uselessPkg packages.useless);
  };
}
