{
  environment.systemPackages = with pkgs; [
    clang
    cmake
    gcc
    gdb
    gnumake
    rustup
  ];

  environment.systemPackages = with pkgs; [
    coreutils
    curl
    fastfetch
    git
    gnutar
    jq
    # killall
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
}
