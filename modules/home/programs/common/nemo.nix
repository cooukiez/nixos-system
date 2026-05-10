/*
  modules/home/programs/common/nemo.nix

  created by ludw
  on 2026-05-07
*/

{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.graphicalPrograms.kitty;
in
{
  config = lib.mkIf cfg {
    dconf.settings = {
      "org/cinnamon/desktop/applications/terminal" = {
        exec = "${lib.getExe pkgs.kitty}";
      };

      "org/cinnamon/desktop/interface" = {
        can-change-accels = true;
      };

      "org/nemo/preferences" = {
        click-policy = "double";

        "default-folder-viewer" = "list-view";
        "inherit-folder-viewer" = true;

        date-format = "informal";

        show-advanced-permissions = true;
        show-hidden-files = false;
        show-full-path-titles = true;

        size-prefixes = "base-10";

        show-reload-icon-toolbar = true;
        show-home-icon-toolbar = true;
        show-computer-icon-toolbar = false;

        show-edit-icon-toolbar = true;
        show-open-in-terminal-toolbar = false;
        show-new-folder-icon-toolbar = true;
        show-show-thumbnails-toolbar = false;
      };

      "org/nemo/preferences/menu-config" = {
        selection-menu-copy-to = false;
        selection-menu-move-to = false;
        selection-menu-duplicate = true;
        selection-menu-make-link = true;
      };
    };

    # keybord shortcuts
    home.file = {
      ".gnome2/accels/nemo".text = ''
        (gtk_accel_path "<Actions>/DirViewActions/OpenInTerminal" "F4")
      '';
    };
  };
}
