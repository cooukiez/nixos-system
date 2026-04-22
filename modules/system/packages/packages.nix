{
  inputs,
  pkgs,
  hostConfig,
  ...
}:
{
  #
  # core
  #
  core = with pkgs; [
    coreutils
    curl
    fastfetch
    git
    gnutar
    htop
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

  nix = with pkgs; [
    nixfmt-rfc-style
    nixfmt-tree
    nix-prefetch-git
    nix-search
  ];

  secrets = with pkgs; [
    age
    authelia
    openssl

    inputs.agenix.packages.${hostConfig.hostSystem}.default
  ];

  utils = with pkgs; [
    bench
    btop
    diff-so-fancy
    diffutils
    dog
    entr
    eza
    fdupes
    fff
    fzf
    glances
    hexdump
    hyperfine
    just
    mani
    navi
    neofetch
    procs
    rip2
    ripgrep
    s-tui
    scc
    tealdeer
    tldr
    toybox
    wiper
  ];

  #
  # general
  #
  dev = with pkgs; [
    clang
    cmake
    gcc
    gdb
    gdb-dashboard
    gnumake
    mariadb
    rustup
    shader-slang
    shaderc

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
    duf
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

  hardwareCore = with pkgs; [
    cpuid
    dmidecode
    intel-gpu-tools
    mesa
    nvtopPackages.intel
    powertop
  ];

  hardwareDesktop = with pkgs; [
    bluez-tools
    brightnessctl
    s0ix-selftest-tool
    v4l-utils
    vulkan-tools
  ];

  #
  # media
  #
  mediaCore = with pkgs; [
    exiftool
    ffmpeg
    imagemagick
    poppler-utils
    shared-mime-info
  ];

  mediaExtra = with pkgs; [
    bpm-tools
    cairo
    cmus
    gphoto2
    icon-slicer
    leptonica
    libpng
    metadata
    playerctl
    sla2pdf
    tesseract
    yt-dlp
  ];

  #
  # disabled
  #
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
