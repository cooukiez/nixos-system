{
  config,
  wlib,
  lib,
  ...
}:
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
                description = "Hypridle configuration value";
              };
          in
          valueType;

        default = { };

        description = ''
          Hypridle configuration written in Nix. Entries with the same key should
          be written as lists. Variable names and colors should be quoted. See
          <https://wiki.hypr.land/Hypr-Ecosystem/hypridle/> for more examples.
        '';
      };

      importantPrefixes = lib.mkOption {
        type = with lib.types; listOf str;
        default = [
          "$"
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
          Extra configuration lines to add to `hypridle.conf`.
        '';
      };
    };

    config.env =
      let
        hypridleConf =
          (lib.optionalString (config.settings != { }) (
            (import ./generators.nix { inherit lib; }).toHyprconf {
              attrs = config.settings;
              importantPrefixes = config.importantPrefixes ++ lib.optional config.sourceFirst "source";
            }
          ))
          + lib.optionalString (config.extraConfig != "") config.extraConfig;

        # create directory structure that matches ~/.config/hypr/hypridle.conf
        configDir = config.pkgs.runCommand "hypridle-config" { } ''
          mkdir -p $out/hypr
          cp ${config.pkgs.writeText "hypridle.conf" hypridleConf} $out/hypr/hypridle.conf
        '';
      in
      {
        XDG_CONFIG_DIRS = "${configDir}";
      };

    config.package = config.pkgs.hypridle;
    config.filesToPatch = [
      "share/systemd/user/hypridle.service"
    ];

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
