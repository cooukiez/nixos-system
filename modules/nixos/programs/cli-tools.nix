/*
  modules/nixos/programs/cli-tools.nix

  created by ludw
  on 2026-02-26
*/

{
  pkgs,
  ...
}:
let
  clear-logs = pkgs.writeShellScriptBin "clear-logs" (builtins.readFile ./scripts/clear-logs.sh);
  cp-fonts = pkgs.writeShellScriptBin "cp-fonts" (builtins.readFile ./scripts/cp-fonts.sh);
  del-snaps = pkgs.writeShellScriptBin "del-snaps" (builtins.readFile ./scripts/del-snaps.sh);
  edit-secret = pkgs.writeShellScriptBin "edit-secret" (builtins.readFile ./scripts/edit-secret.sh);
  fix-perms = pkgs.writeShellScriptBin "fix-perms" (builtins.readFile ./scripts/fix-perms.sh);
  snaps-du = pkgs.writeShellScriptBin "snaps-du" (builtins.readFile ./scripts/snaps-du.sh);
  sync-flake = pkgs.writeShellScriptBin "sync-flake" (builtins.readFile ./scripts/sync-flake.sh);
in
{
  programs.nix-ld.enable = true;
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/etc/nixos"; # sets NH_OS_FLAKE variable for you
  };

  # nvim base editor
  programs.neovim.enable = true;

  environment.systemPackages = with pkgs; [
    ### tui tools, sorted alphabetically ###

    bandwhich # network bandwidth monitor
    bat # file viewer with syntax highlighting
    bottom # interactive system monitor
    btop # system monitor with curses interface
    cmus # terminal music player
    cointop # cryptocurrency dashboard
    duf # disk usage viewer
    fff # simple file
    gdb-dashboard # gdb interface
    glances # system monitor with curses interface
    htop # interactive process viewer
    khal # interactive calendar client
    lazygit # interactive git client
    navi # interactive cheatsheet browser
    powertop # power consumption monitor
    procs # interactive process viewer
    s-tui # monitoring tool
    taskwarrior2 # task manager
    wiper # disk analyzer and cleanup tool

    ### cli tools, sorted alphabetically ###

    bench
    bitwarden-cli
    bpm-tools
    brightnessctl
    cdparanoia
    clean
    dfc
    diff-so-fancy
    dog
    dua
    entr
    eza
    hexdump
    hyperfine
    joplin-cli
    just
    mani
    metadata
    neofetch
    playerctl
    rip2
    ripgrep
    s0ix-selftest-tool
    scc
    sla2pdf
    slack-cli
    tealdeer
    tealdeer
    tldr
    ventoy

    # my system tools
    clear-logs
    cp-fonts
    del-snaps
    edit-secret
    fix-perms
    snaps-du
    sync-flake

    # playful tools
    asciinema
    cmatrix
    cowsay
    figlet
    fortune
    kittysay
    lolcat
    sl
  ];
}
