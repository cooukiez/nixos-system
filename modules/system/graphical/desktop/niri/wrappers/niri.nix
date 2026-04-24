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
        type = types.attrsOf (
          types.oneOf [
            yamlFormat.type
            types.path
            types.lines
          ]
        );

        default = { };
      };

      extraConfig = lib.mkOption {
        type = lib.types.lines;
        default = "";
      };
    };

    config.env =
      let
        compiledConfig =
          (lib.optionalString (config.settings != { }) (
            (import ./generators.nix { inherit lib; }).toKDL { } config.settings
          ))
          + lib.optionalString (config.extraConfig != "") config.extraConfig;

        checkedConfig = config.pkgs.writeTextFile {
          name = "config.kdl";
          text = compiledConfig;
          checkPhase = ''
            ${lib.getExe config.package} validate -c $out
          '';
        };
      in
      {
        NIRI_CONFIG = toString config."config.kdl".path;
      };

    config.package = config.pkgs.niri;
    config.filesToPatch = [
      "share/applications/*.desktop"
      "share/systemd/user/niri.service"
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
