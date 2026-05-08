/*
  modules/home/programs/common/git.nix

  created by ludw
  on 2026-02-26
*/

{
  config,
  pkgs,
  lib,
  userConfig,
  ...
}:
let
  cfg = config.graphicalPrograms.git;
  githubTokenSecretFile = ../../../../secrets/github-token-classic.age;

  gitSecretHelperScript = ''
    if [ "$1" = "get" ]; then
      token=$(cat ${config.age.secrets.github-token.path})
      echo "username=${userConfig.gitName}"
      echo "password=$token"
    fi
  '';

  gitSecretHelper = pkgs.writeShellScript "git-secret-helper" gitSecretHelperScript;
in
{
  config = lib.mkIf cfg {
    age.secrets.github-token.file = githubTokenSecretFile;

    programs.git = {
      enable = true;

      settings = {
        user = {
          name = userConfig.gitName;
          email = userConfig.gitEmail;
        };

        credential.helper = "${gitSecretHelper}";
        credential.credentialStore = "secretservice";
      };
    };

    xdg.configFile."feishin/config.json".text = builtins.toJSON {
      disable_auto_updates = false;
      enableNeteaseTranslation = false;
      global_media_hotkeys = true;
      lyrics = [
        "NetEase"
        "lrclib.net"
      ];
      mediaSession = false;
      playbackType = "web";
      should_prompt_accessibility = true;
      shown_accessibility_warning = false;
      window_enable_tray = true;
      window_exit_to_tray = false;
      window_minimize_to_tray = false;
      window_start_minimized = false;
      window_window_bar_style = "linux";
      "__internal__" = {
        migrations = {
          version = "1.7.0";
        };
      };
      window_has_frame = true;
      bounds = {
        x = 0;
        y = 0;
        width = 1890;
        height = 1136;
      };
      maximized = false;
      fullscreen = false;
      theme = "dark";
      server = { };
    };

  };
}
