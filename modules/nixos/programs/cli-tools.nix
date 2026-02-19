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
  edit-secret = pkgs.writeShellScriptBin "edit-secret" (builtins.readFile ./scripts/edit-secret.sh);
  fix-perms = pkgs.writeShellScriptBin "fix-perms" (builtins.readFile ./scripts/fix-perms.sh);
  snaps-du = pkgs.writeShellScriptBin "snaps-du" (builtins.readFile ./scripts/snaps-du.sh);
in
{
  # nvim base editor
  programs.neovim.enable = true;

  environment.systemPackages = with pkgs; [
    # cli tools, sorted alphabetically
    aria2
    asciinema
    bandwhich
    bat
    bench
    bitwarden-cli
    bottom
    brightnessctl
    browsh
    btop
    buku
    cliphist
    cmatrix
    cmus
    cointop
    cowsay
    ctop
    ddgr
    dfc
    diff-so-fancy
    dog
    dua
    duf
    edit-secret
    entr
    eza
    fff
    figlet
    fix-perms
    fortune
    gdb-dashboard
    glances
    gping
    htop
    httpie
    hyperfine
    joplin-cli
    just
    kdash
    khal
    kittysay
    lazydocker
    lazygit
    lolcat
    mangl
    mani
    manix
    metadata
    most
    mutt
    navi
    neofetch
    newsboat
    ngrok
    playerctl
    procs
    rip2
    ripgrep
    scc
    sd
    sl
    sla2pdf
    slack-cli
    snaps-du
    speedtest-cli
    surge
    taskwarrior2
    tealdeer
    tldr
    tlrc
    tmate
    transfer-sh
    tre
    tuir
    ventoy

    # window / system control
    wmctrl
    xdotool
    xmodmap

    # clipboard tools
    wl-clipboard
    xclip
    xsel

    # screenshot / recording tools
    grim
    slurp
    wf-recorder
  ];
}
