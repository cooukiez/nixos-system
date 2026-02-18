{
  pkgs,
  ...
}:
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
    entr
    eza
    fff
    figlet
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
