{
  inputs,
  config,
  lib,
  ...
}:
let
  wlib = inputs.wrappers.lib;
in
wlib.wrapModule (
  {
    config,
    wlib,
    lib,
    ...
  }:
  {
    _class = "wrapper";

    options = {
      settings = lib.mkOption {
        type =
          with lib.types;
          let
            valueType =
              nullOr (oneOf [
                bool
                int
                float
                str
                path
                (attrsOf valueType)
                (listOf valueType)
              ])
              // {
                description = "Hyprlock configuration value";
              };
          in
          valueType;

        default = { };

        description = ''
          Hyprlock configuration written in Nix. Entries with the same key should
          be written as lists. Variable names and colors should be quoted. See
          <https://wiki.hypr.land/Hypr-Ecosystem/hyprlock/> for more examples.
        '';
      };

      importantPrefixes = lib.mkOption {
        type = with lib.types; listOf str;
        default = [
          "$"
          "bezier"
          "monitor"
          "size"
        ];

        description = ''
          List of important prefixes to source at the top of the config.
        '';
      };

      sourceFirst = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to put source entries at the top of the configuration.";
      };

      extraConfig = lib.mkOption {
        type = lib.types.lines;
        default = "";
        description = ''
          Extra configuration lines to add to `hyprlock.conf`.
        '';
      };
    };

    config.env =
      let
        hyprlockConf =
          (lib.optionalString (config.settings != { }) (
            (import ./generators.nix { inherit lib; }).toHyprconf {
              attrs = config.settings;
              importantPrefixes = config.importantPrefixes ++ lib.optional config.sourceFirst "source";
            }
          ))
          + lib.optionalString (config.extraConfig != "") config.extraConfig;

        # create directory structure that matches ~/.config/hypr/hyprlock.conf
        configDir = config.pkgs.runCommand "hyprlock-config" { } ''
          mkdir -p $out/hypr
          cp ${config.pkgs.writeText "hyprlock.conf" hyprlockConf} $out/hypr/hyprlock.conf
        '';
      in
      {
        XDG_CONFIG_DIRS = "${configDir}";
      };

    config.package = config.pkgs.hyprlock;

    config.meta.platforms = lib.platforms.linux;
    config.meta.maintainers = [
      {
        name = "cooukiez";
        github = "cooukiez";
        githubId = 61082023;
      }
    ];
  }
)
