/*
  modules/nixos/programs/cli-tools.nix

  created by ludw
  on 2026-02-18
*/

{
  pkgs,
  ...
}:
let
  del-snaps = pkgs.writeShellScriptBin "del-snaps" (builtins.readFile ./scripts/del-snaps.sh);
  edit-secret = pkgs.writeShellScriptBin "edit-secret" (builtins.readFile ./scripts/edit-secret.sh);
  fix-perms = pkgs.writeShellScriptBin "fix-perms" (builtins.readFile ./scripts/fix-perms.sh);
  snaps-du = pkgs.writeShellScriptBin "snaps-du" (builtins.readFile ./scripts/snaps-du.sh);
in
{
  # nvim base editor
  programs.neovim.enable = true;

  environment.systemPackages = with pkgs; [
    bat # file viewer with syntax highlighting
    bottom # interactive system monitor
    cmus # terminal music player
    cointop # cryptocurrency dashboard
    ctop # container metrics dashboard
    duf # disk usage viewer
    fff # simple file
    gdb-dashboard # gdb interface
    glances # system monitor with curses interface
    gping # ping visualizer
    htop # interactive process viewer
    khal # interactive calendar client
    lazydocker # interactive docker manager
    lazygit # interactive git client
    navi # interactive cheatsheet browser
    newsboat # RSS feed reader
    procs # interactive process viewer
    taskwarrior2 # TUI task manager
    tuir # reddit terminal client
    bandwhich # network bandwidth monitor
    btop # system monitor with curses interface

    # cli tools, sorted alphabetically
    aria2
    bench
    bitwarden-cli
    clean
    ddgr
    dfc
    diff-so-fancy
    dog
    dua
    entr
    eza
    httpie
    hyperfine
    joplin-cli
    just
    mani
    ngrok
    powertop
    rip2
    ripgrep
    scc
    sla2pdf
    slack-cli
    speedtest-cli
    surge
    tealdeer
    tldr
    tlrc
    tlrc

    # my system tools
    del-snaps
    edit-secret
    fix-perms
    snaps-du

    # playful tools
    asciinema
    cmatrix
    cowsay
    figlet
    fortune
    kittysay
    lolcat
    sl

    # window / system control
    brightnessctl
    playerctl
    wmctrl
    xdotool
    xmodmap

    # clipboard / screenshot /
    cliphist
    grim
    slurp
    wf-recorder
    wl-clipboard
    xclip
    xsel
  ];
}
