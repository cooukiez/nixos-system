#!/usr/bin/env bash

# define directories
SCREENSHOT_DIR=~/Pictures/Screenshots
RECORDING_DIR=~/Videos/Captures

# create directories if they don't exist
mkdir -p "$SCREENSHOT_DIR" "$RECORDING_DIR"

# generate filename with timestamp
timestamp=$(date +%Y-%m-%d_%H-%M-%S-%3N)

case "$1" in
  0)
    # fullscreen screenshot
    filename="$SCREENSHOT_DIR/Screenshot-$timestamp.png"
    grim "$filename" && wl-copy < "$filename"
    notify-send --app-name="Screencapture" "Screenshot" "Screenshot of entire screen captured." -i "$filename"
    ;;
  1)
    # region screenshot
    filename="$SCREENSHOT_DIR/Screenshot-$timestamp.png"
    grim -g "$(slurp -d)" "$filename"
    wl-copy < "$filename"
    notify-send --app-name="Screencapture" "Screenshot" "Screenshot of selected region captured." -i "$filename"
    ;;
  2)
    # fullscreen recording
    filename="$RECORDING_DIR/Recording-$timestamp.mp4"
    wf-recorder -f "$filename"
    wl-copy "$filename"
    notify-send --app-name="Screencapture" "Recording saved" "Screen recording of entire screen saved." -i video-x-generic
    ;;
  3)
    # region recording
    filename="$RECORDING_DIR/Recording-$timestamp.mp4"
    wf-recorder -g "$(slurp)" -f "$filename"
    wl-copy "$filename"
    notify-send --app-name="Screencapture" "Recording saved" "Screen recording of selected region saved." -i video-x-generic
    ;;
  stop)
    # stop recording
    pkill -INT wf-recorder
    notify-send --app-name="Screencapture" "Recording stopped" "Recording has been stopped." -i video-x-generic
    ;;
  *)
    echo "Usage: $0 [0|1|2|3|stop]"
    echo "  0: Fullscreen screenshot"
    echo "  1: Region screenshot"
    echo "  2: Fullscreen recording"
    echo "  3: Region recording"
    echo "  stop: Stop recording"
    exit 1
    ;;
esac