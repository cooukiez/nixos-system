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

  corePluginConfig = {
    # enabled
    backlink = true;
    bookmarks = true;
    canvas = true;
    command-palette = true;
    editor-status = true;
    file-explorer = true;
    file-recovery = true;
    global-search = true;
    graph = true;
    note-composer = true;
    outgoing-link = true;
    outline = true;
    page-preview = true;
    properties = true;
    switcher = true;
    tag-pane = true;

    # disabled
    audio-recorder = false;
    daily-notes = false;
    footnotes = false;
    markdown-importer = false;
    publish = false;
    random-note = false;
    slash-command = false;
    slides = false;
    sync = false;
    templates = false;
    webviewer = false;
    word-count = false;
    workspaces = false;
    zk-prefixer = false;
  };

  communityPluginConfig = {
    # enabled
    advanced-canvas = true;
    automatic-table-of-contents = true;
    better-export-pdf = true;
    better-word-count = true;
    colored-tags = true;
    colored-text = true;
    dataview = true;
    hotkeysplus-obsidian = true;
    image-captions = true;
    image-converter = true;
    make-md = true;
    obsidian-banners = true;
    obsidian-git = true;
    obsidian-icon-folder = true;
    obsidian-kanban = true;
    obsidian-latex-suite = true;
    obsidian-link-embed = true;
    obsidian-pandoc = true;
    obsidian-plantuml = true;
    obsidian-regex-replace = true;
    obsidian-style-settings = true;
    obsidian-timeline = true;
    table-editor-obsidian = true;

    # disabled
    obsidian-enhancing-export = false;
    obsidian-hider = false;
    obsidian-image-layouts = false;
    obsidian-trim-whitespace = false;
    print = false;
    templater-obsidian = false;
  };
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
              landscape = false;
              downscalePercent = 100;
              margin = "0";
            };
          };

          appearance = {
            interfaceFontFamily = "Inter";
            monospaceFontFamily = "JetBrainsMono NF";
            baseFontSize = 16;

            enabledCssSnippets = [ "Stylix Config" ];
          };

          corePlugins =
            let
              enabledKeys = builtins.filter (name: corePluginConfig.${name}) (
                builtins.attrNames corePluginConfig
              );
            in
            map (name: { inherit name; }) enabledKeys;

          communityPlugins =
            let
              enabledKeys = builtins.filter (name: communityPluginConfig.${name}) (
                builtins.attrNames communityPluginConfig
              );
            in
            map (name: pkgs.obsidianPlugins.${name}) enabledKeys;
        };
      };
    };
  };
}
