/*
  modules/home/programs/vscode.nix

  created by ludw
  on 2026-02-16
*/

{
  # fix for vscode keyring
  home.file.".vscode/argv.json".text = ''
    {
      "password-store": "gnome-libsecret",
      "enable-crash-reporter": true,
      "enable-crash-reporter": true
    }
  '';

  programs.vscode = {
    enable = true;

    profiles.default = {
      userSettings = {
        "settingsSync.ignoredSettings" = [
          # "window.titleBarStyle"
          # "window.controlsStyle"
        ];

        "window.titleBarStyle" = "custom";
        "window.controlsStyle" = "hidden";

        "editor.insertSpaces" = true;
        "editor.tabSize" = 2;
        "editor.detectIndentation" = false;

        "editor.formatOnSave" = true;
        "editor.semanticHighlighting.enabled" = true;
        "editor.unicodeHighlight.nonBasicASCII" = false;
        "editor.largeFileOptimizations" = false;
        "editor.showUnused" = false; # hide unused warnings
        "editor.guides.bracketPairs" = true;

        "editor.fontFamily" = "JetBrainsMono NF";
        "editor.codeLensFontFamily" = "JetBrainsMono NF";

        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "explorer.confirmPasteNative" = false;

        "terminal.integrated.defaultProfile.windows" = "Command Prompt";

        "tinymist.exportPdf" = "onSave";
        "redhat.telemetry.enabled" = false;

        "security.allowedUNCHosts" = [
          # "192.168.178.30"
          # "192.168.178.24"
          # "192.168.178.65"
        ];

        "autoAlign.associations" = {
          "csv" = ",";
          "bsv" = "|";
          "" = "#";
        };

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

        "editorGutter.modifiedBackground" = "#00000000"; # transparent modified gutter
        "editorGutter.addedBackground" = "#00000000"; # transparent added gutter
        "editorGutter.deletedBackground" = "#00000000"; # transparent deleted gutter
        "editorGutter.warningBackground" = "#00000000"; # transparent warning gutter
        "editorGutter.errorBackground" = "#00000000"; # transparent error gutter

        "favouriteThemes.pinnedThemes" = [
          "Ardent (contrast 0, chroma 0, lightness 0)"
          "Ardent (contrast 1, chroma 0, lightness 5)"
          "Ardent (contrast 1, chroma 1, lightness 5)"
          "Catppuccin Frappe"
          "Catppuccin Frappe Darker"
          "Catppuccin Macchiato"
          "Catppuccin Mocha"
          "Dainty – Nord (chroma 0, lightness 0)"
          "Dainty – Nord (chroma 0, lightness 4)"
          "Material Theme"
          "Material Theme Ocean"
          "Material Theme Palenight"
          "Nathan's Gruvbox"
          "Night Owl"
          "Night Owl Light"
          "Red"
          "Shades of Purple (Super Dark)"
          "Tokyo Night"
          "Tokyo Night Dark"
          "Tokyo Night Light"
        ];

        # git configuration
        "git.autofetch" = true;
        "git.enableSmartCommit" = true;
        "git.confirmSync" = false;

        "github.copilot.editor.enableAutoCompletions" = true;
        "github.copilot.nextEditSuggestions.enabled" = true;
        "github.copilot.nextEditSuggestions.fixes" = false;

        "gitlens.ai.model" = "vscode";
        "gitlens.ai.vscode.model" = "copilot:gpt-4.1";

        #
        # language configuarations
        #

        "[python]" = {
          "editor.semanticHighlighting.enabled" = true;
          "editor.defaultFormatter" = "charliermarsh.ruff";
        };

        "[xml]" = {
          "editor.defaultFormatter" = "DotJoshJohnson.xml";
        };

        # shader languages
        "[glsl]" = { };

        "glsl-lsp.syntaxHighlighting.highlightEntireFile" = true;
        "glsllint.glslangValidatorArgs" = [
          "-V"
        ];

        "wgsl-analyzer.server.path" = "~/.cargo/bin/wgsl_analyzer";

        # binary files
        "[code-text-binary]" = { };

        "hexeditor.columnWidth" = 32;
        "hexeditor.showDecodedText" = false;
        "hexeditor.defaultEndianness" = "little";
        "hexeditor.inspectorType" = "aside";

        # c / cpp / cmake configuration
        "[c]" = {
          "editor.wordBasedSuggestions" = "matchingDocuments";
          "editor.suggest.insertMode" = "replace";
          "editor.semanticHighlighting.enabled" = true;
          "editor.defaultFormatter" = "xaver.clang-format";
        };

        "[cpp]" = {
          "editor.defaultFormatter" = "xaver.clang-format";
        };

        "cmake.configureOnOpen" = true;
        "cmake.options.statusBarVisibility" = "visible";
        "cmake.showOptionsMovedNotification" = false;

        "cmake.additionalCompilerSearchDirs" = [
          "C:\\Program Files\\MinGW\\bin"
        ];

        "cmake.debugConfig" = {
          "externalConsole" = true;
        };

        "C_Cpp.default.compilerPath" = "";
        "C_Cpp.default.cStandard" = "c99";

        # typst configuration
        "[typst]" = {
          "editor.wordSeparators" = "`~!@#$%^&*()=+[{]}\\|;:'\",.<>/?";
        };

        "[typst-code]" = {
          "editor.wordSeparators" = "`~!@#$%^&*()=+[{]}\\|;:'\",.<>/?";
        };

        "typst-lsp.experimentalFormatterMode" = "on";
        "typst-lsp.trace.server" = "messages";

        # typescript configuration
        "[typescript]" = {
          "editor.defaultFormatter" = "vscode.typescript-language-features";
        };

        "typescript.updateImportsOnFileMove.enabled" = "always";

        "svelte.enable-ts-plugin" = true;

        # qml
        "[qml]" = {
          "editor.defaultFormatter" = "Delgan.qml-format";
        };
      };
    };
  };
}
