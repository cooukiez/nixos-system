/*
modules/home/programs/common/vscode/default.nix

part of nixos system
created 2026-02-26 by ludw
*/
{
  config,
  pkgs,
  pkgConfig,
  hostConfig,
  lib,
  ...
}: let
  cfg = config.graphicalPrograms.vscode;

  myExtensions = with pkgs.vscode-extensions; [
    fill-labs.dependi
    # hbenl.vscode-test-explorer
    usernamehw.errorlens

    ms-vscode-remote.remote-containers
    ms-vscode-remote.remote-ssh
    ms-vscode-remote.remote-ssh-edit
    ms-vscode.remote-explorer

    tomoki1207.pdf

    # git
    donjayamanne.githistory
    codezombiech.gitignore
    # eamodio.gitlens

    # fabiospampinato.vscode-open-in-github
    # github.vscode-pull-request-github

    #
    # languages
    #

    # nix
    jnoortheen.nix-ide

    # rust
    rust-lang.rust-analyzer

    # python
    ms-python.python
    charliermarsh.ruff

    ms-python.black-formatter
    ms-python.debugpy
    ms-python.vscode-pylance

    ms-toolsai.jupyter
    ms-toolsai.jupyter-keymap
    ms-toolsai.jupyter-renderers
    ms-toolsai.vscode-jupyter-cell-tags
    ms-toolsai.vscode-jupyter-slideshow

    njpwerner.autodocstring

    # c / cpp
    ms-vscode.cpptools-extension-pack
    ms-vscode.cpptools

    vadimcn.vscode-lldb

    ms-vscode.cmake-tools
    twxs.cmake

    xaver.clang-format
    llvm-vs-code-extensions.vscode-clangd

    # shader
    wgsl-analyzer.wgsl-analyzer

    # cs
    ms-dotnettools.csdevkit
    ms-dotnettools.csharp
    ms-dotnettools.vscode-dotnet-runtime

    # unity
    visualstudiotoolsforunity.vstuc

    # markdown
    yzhang.markdown-all-in-one

    davidanson.vscode-markdownlint
    chrischinchilla.vscode-pandoc

    # web
    ecmel.vscode-html-css

    bmewburn.vscode-intelephense-client
    xdebug.php-debug

    bierner.comment-tagged-templates
    yoavbls.pretty-ts-errors

    svelte.svelte-vscode

    # java
    redhat.java

    vscjava.vscode-java-debug
    vscjava.vscode-java-dependency
    vscjava.vscode-gradle
    vscjava.vscode-maven

    vscjava.vscode-java-test

    # typst
    myriad-dreamin.tinymist

    # binary
    ms-vscode.hexeditor

    # file formats
    mechatroner.rainbow-csv
    tamasfe.even-better-toml
    redhat.vscode-yaml

    dotjoshjohnson.xml
    redhat.vscode-xml
  ];
in {
  config = {
    programs.vscode = lib.mkIf cfg {
      enable = true;
      package = pkgConfig.vscode;

      profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;

        extensions = myExtensions;

        userSettings =
          {
            "settingsSync" = 0;
            "settingsSync.ignoredSettings" = [];

            "security.allowedUNCHosts" = [];

            "window.titleBarStyle" = "custom";
            "window.controlsStyle" = "hidden";

            "keyboard.dispatch" = "keyCode";

            "workbench.startupEditor" = "none";
            "workbench.welcomePage.walkthroughs.openOnInstall" = false;
            "walkthroughs.enabled" = false;

            # core editor
            "editor.detectIndentation" = false;
            "editor.insertSpaces" = true;
            "editor.tabSize" = 2;

            "editor.fontFamily" = "JetBrainsMono NF";
            "editor.codeLensFontFamily" = "JetBrainsMono NF";

            "editor.formatOnSave" = true;
            "editor.largeFileOptimizations" = true;

            "editor.guides.bracketPairs" = true;
            "editor.semanticHighlighting.enabled" = true;
            "editor.unicodeHighlight.nonBasicASCII" = false;
            "editor.showUnused" = true;

            "explorer.confirmDelete" = false;
            "explorer.confirmDragAndDrop" = false;
            "explorer.confirmPasteNative" = false;
          }
          // {
            # customizations
            "workbench.colorCustomizations" = {
              "tab.activeBorder" = "#00000000";
              "tab.activeBorderTop" = "#00000000";
              "tab.activeModifiedBorder" = "#00000000";
              "tab.unfocusedActiveBorder" = "#00000000";
              "tab.unfocusedActiveBorderTop" = "#00000000";
              "activityBar.foreground" = "#ebebeb";
              "activityBar.activeBorder" = "#ebebeb";
            };

            "editorGutter.modifiedBackground" = "#00000000";
            "editorGutter.addedBackground" = "#00000000";
            "editorGutter.deletedBackground" = "#00000000";
            "editorGutter.warningBackground" = "#00000000";
            "editorGutter.errorBackground" = "#00000000";
          }
          // {
            "nix.enableLanguageServer" = true;
            "nix.serverPath" = "${lib.getExe pkgs.nixd}";

            "nix.formatterPath" = "${lib.getExe pkgs.alejandra}";

            "nix.serverSettings" = {
              "nixd" = {
                "formatting" = {
                  "command" = ["${lib.getExe pkgs.alejandra}"];
                };
                "options" = {
                  "nixos" = {
                    "expr" = "(builtins.getFlake \"\${workspaceFolder}\").nixosConfigurations.${hostConfig.hostname}.options";
                  };
                };
              };
            };
          }
          // {
            "redhat.telemetry.enabled" = false;

            # git configuration
            "git.autofetch" = true;
            "git.enableSmartCommit" = true;
            "git.confirmSync" = false;

            "github.copilot.editor.enableAutoCompletions" = true;
            "github.copilot.nextEditSuggestions.enabled" = true;
            "github.copilot.nextEditSuggestions.fixes" = false;

            "autoAlign.associations" = {
              "csv" = ",";
              "bsv" = "|";
              "" = "#";
            };

            "tinymist.exportPdf" = "onSave";

            "hexeditor.columnWidth" = 32;
            "hexeditor.showDecodedText" = false;
            "hexeditor.defaultEndianness" = "little";
            "hexeditor.inspectorType" = "aside";
          };

        keybindings = [
          {
            key = "ctrl+d";
            command = "editor.action.copyLinesDownAction";
            when = "textInputFocus && !editorReadonly";
          }
          {
            key = "ctrl+z";
            command = "undo";
            when = "textInputFocus && !editorReadonly";
          }
          {
            key = "ctrl+y";
            command = "redo";
            when = "textInputFocus && !editorReadonly";
          }
          {
            key = "ctrl+shift+z";
            command = "redo";
            when = "textInputFocus && !editorReadonly";
          }
        ];
      };
    };

    # fix vscode keyring
    home.file.".vscode/argv.json".text = ''
      {
        "password-store": "gnome-libsecret",
        "enable-crash-reporter": true
      }
    '';
  };
}
