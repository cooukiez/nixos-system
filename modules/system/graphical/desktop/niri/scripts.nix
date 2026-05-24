/*
modules/system/graphical/desktop/niri/scripts.nix

part of nixos system
created 2026-04-23 by ludw
*/
{pkgs, ...}: {
  screenshotFull = pkgs.writeShellScriptBin "screenshot-full" ''
    ${pkgs.coreutils}/bin/mkdir -p ~/Pictures/Screenshots
    f=~/Pictures/Screenshots/Screenshot-$(${pkgs.coreutils}/bin/date +%Y-%m-%d_%H-%M-%S-%3N).png

    ${pkgs.grim}/bin/grim "$f" &&
    ${pkgs.wl-clipboard}/bin/wl-copy < "$f" &&

    ${pkgs.libnotify}/bin/notify-send --app-name=Screencapture Screenshot "Screenshot of entire screen captured." -i "$f"
  '';

  screenshotRegion = pkgs.writeShellScriptBin "screenshot-region" ''
    ${pkgs.coreutils}/bin/mkdir -p ~/Pictures/Screenshots
    f=~/Pictures/Screenshots/Screenshot-$(${pkgs.coreutils}/bin/date +%Y-%m-%d_%H-%M-%S-%3N).png

    ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -d)" "$f" &&
    ${pkgs.wl-clipboard}/bin/wl-copy < "$f" &&

    ${pkgs.libnotify}/bin/notify-send --app-name=Screencapture Screenshot "Screenshot of selected region captured." -i "$f"
  '';

  recordFull = pkgs.writeShellScriptBin "record-full" ''
    ${pkgs.coreutils}/bin/mkdir -p ~/Videos/Captures
    f=~/Videos/Captures/Recording-$(${pkgs.coreutils}/bin/date +%Y-%m-%d_%H-%M-%S-%3N).mp4

    ${pkgs.wf-recorder}/bin/wf-recorder -f "$f"
    ${pkgs.wl-clipboard}/bin/wl-copy "$f"

    ${pkgs.libnotify}/bin/notify-send --app-name=Screencapture "Recording saved" "Screen recording saved." -i video-x-generic
  '';

  recordRegion = pkgs.writeShellScriptBin "record-region" ''
    ${pkgs.coreutils}/bin/mkdir -p ~/Videos/Captures
    f=~/Videos/Captures/Recording-$(${pkgs.coreutils}/bin/date +%Y-%m-%d_%H-%M-%S-%3N).mp4

    ${pkgs.wf-recorder}/bin/wf-recorder -g "$(${pkgs.slurp}/bin/slurp)" -f "$f"
    ${pkgs.wl-clipboard}/bin/wl-copy "$f"

    ${pkgs.libnotify}/bin/notify-send --app-name=Screencapture "Recording saved" "Screen recording saved." -i video-x-generic
  '';

  recordStop = pkgs.writeShellScriptBin "record-stop" ''
    ${pkgs.procps}/bin/pkill -INT wf-recorder
    ${pkgs.libnotify}/bin/notify-send --app-name=Screencapture "Recording stopped" "Recording has been stopped." -i video-x-generic
  '';
}
