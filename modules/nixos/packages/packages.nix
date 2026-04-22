{
  inputs,
  hostSystem,
  ...
}:
{
  core = with pkgs; [
    coreutils
    curl
    fastfetch
    git
    gnutar
    jq
    lsof
    psmisc
    rclone
    rsync
    sd
    tree
    unzip
    wget
    zip
  ];

  dev = with pkgs; [
    clang
    cmake
    gcc
    gdb
    gdb-dashboard
    gnumake
    rustup
    shader-slang
    shaderc

    # python
    (python3.withPackages (
      ps: with ps; [
        emoji
        numpy
        pandas
      ]
    ))
  ];

  filesystem = with pkgs; [
    cdparanoia
    cdrkit
    cdrtools
    cifs-utils
    dfc
    dua
    exfatprogs
    fuse
    fuse3
    ifuse
    libburn
    libimobiledevice
    libimobiledevice-glue
    mtools
    ntfsprogs
    parted
    unixtools.quota
    ventoy
  ];

  utils = with pkgs; [
    bench
    diff-so-fancy
    diffutils
    dog
    entr
    eza
    fdupes
    fzf
    hexdump
    hyperfine
    just
    mani
    neofetch
    rip2
    ripgrep
    scc
    tealdeer
    tldr
    toybox
  ];

  hardware = with pkgs; [
    bluez-tools
    brightnessctl
    cpuid
    dmidecode
    intel-gpu-tools
    mesa
    nvtopPackages.intel
    s0ix-selftest-tool
    v4l-utils
    vulkan-tools
  ];

  secrets = with pkgs; [
    age
    authelia
    openssl

    inputs.agenix.packages.${hostSystem}.default
  ];

  nix-utils = with pkgs; [
    nixfmt-rfc-style
    nixfmt-tree
    nix-prefetch-git
    nix-search
  ];

  media = with pkgs; [
    bpm-tools
    cmus
    exiftool
    ffmpeg
    gphoto2
    icon-slicer
    imagemagick
    libpng
    metadata
    playerctl
    poppler-utils
    shared-mime-info
    sla2pdf
    tesseract
    yt-dlp
  ];

  tui = with pkgs; [
    bandwhich # network bandwidth monitor
    btop # system monitor with curses interface
    duf # disk usage viewer
    fff # simple file viewer
    glances # system monitor with curses interface
    htop # interactive process viewer
    lazygit # interactive git client
    navi # interactive cheatsheet browser
    powertop # power consumption monitor
    procs # interactive process viewer
    s-tui # monitoring tool
    wiper # disk analyzer and cleanup tool
  ];

  useless = with pkgs; [
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
