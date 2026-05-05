/*
  modules/home/programs/zathura.nix

  created by ludw
  on 2026-02-26
*/

{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.graphicalPrograms.obsidian;
in
{
  config = lib.mkIf cfg {
    programs.obsidian = {
      enable = true;

      vaults.vault = {
        enable = true;
        target = "Vault";

        settings = {
          app = {
            alwaysUpdateLinks = true;

            attachmentFolderPath = "Attachments";
            spellcheck = false;

            pdfExportSettings = {
              includeName = true;
              pageSize = "A4";
              downscalePercent = 100;
              margin = "0";
              landscape = false;
            };
          };

          communityPlugins = with pkgs.obsidianPlugins; [
            advanced-canvas
            automatic-table-of-contents
            better-export-pdf
            better-word-count
            colored-tags
            colored-text
            dataview
            hotkeysplus-obsidian
            image-captions
            image-converter
            make-md
            obsidian-banners
            obsidian-git
            obsidian-icon-folder
            obsidian-kanban
            obsidian-latex-suite
            obsidian-link-embed
            obsidian-pandoc
            obsidian-plantuml
            obsidian-regex-replace
            obsidian-style-settings
            obsidian-timeline
            table-editor-obsidian
          ];
        };
      };
    };
  };
}
