/*
  modules/nixos/common/default.nix

  created by ludw
  on 2026-02-17
*/

{
  pkgs,
  ...
}:
{
  imports = [
    ./display.nix
    ./drive.nix
    ./hardware.nix
    ./libs.nix
  ];

  services.dbus.enable = true;

  # common container config
  virtualisation = {
    containers.enable = true;
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };

    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  environment.sessionVariables = {
    # set LIBVA_DRIVER_NAME environment variable for video acceleration
    LIBVA_DRIVER_NAME = "iHD";

    # fix for nautilus extension path
    NAUTILUS_EXTENSION_DIR = "${pkgs.nautilus-python}/lib/nautilus/extensions";
    NAUTILUS_4_EXTENSION_DIR = "${pkgs.nautilus-python}/lib/nautilus/extensions-4";

    VCPKG_FORCE_SYSTEM_BINARIES = 1;
  };

  environment.pathsToLink = [
    "/share/nautilus-python/extensions"
  ];

  programs.nix-ld.enable = true;

  # zsh shell
  programs.zsh.enable = true;

  # system packages
  environment.systemPackages = with pkgs; [
    # core packages, sorted alphabetically
    cifs-utils
    clang
    cmake
    coreutils
    cpuid
    curl
    diffutils
    dmidecode
    exfatprogs
    exiftool
    fastfetch
    fdupes
    fzf
    gcc
    gdb
    git
    glib
    gnumake
    gnutar
    inetutils
    jq
    killall
    mesa
    mtools
    ntfsprogs
    parted
    rclone
    rsync
    rustup
    shared-mime-info
    toybox
    tree
    unixtools.quota
    unzip
    wget
    zip

    # nixos related
    home-manager
    nixfmt-rfc-style
    nixfmt-tree
    nix-prefetch-git
    nix-search
  ];
}
