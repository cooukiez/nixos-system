{
  pkgs,
  ...
}:
let
  resHD = {
    w = "1920";
    h = "1200";
  };

  resFull = {
    w = "3480";
    h = "2400";
  };
in
{
  lowRes = pkgs.writeShellScriptBin "low-res" ''
    ${pkgs.niri}/bin/niri msg output "eDP-1" custom-mode "${resHD.w}x${resHD.h}@60.000"
    ${pkgs.niri}/bin/niri msg output "eDP-1" scale 1.0

    ${pkgs.libnotify}/bin/notify-send --app-name="Niri Compositor" "Screen resolution changed" "Changed monitor mode to 1920x1200@60."
  '';

  highRes = pkgs.writeShellScriptBin "high-res" ''
    ${pkgs.niri}/bin/niri msg output "eDP-1" mode "${resFull.w}x${resFull.h}@60.000"
    ${pkgs.niri}/bin/niri msg output "eDP-1" scale 2.0

    ${pkgs.libnotify}/bin/notify-send --app-name="Niri Compositor" "Screen resolution changed" "Changed monitor mode to 3480x2160@60."
  '';

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
