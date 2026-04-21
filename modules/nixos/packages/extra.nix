{
  environment.systemPackages = with pkgs; [
    diffutils
    fdupes
    fzf
    toybox

    # hardware
    cpuid
    # drivers
    mesa
    dmidecode

    # networking
    inetutils

    # secrets
    age
    openssl

    inputs.agenix.packages.${hostSystem}.default

    # nix utils
    nixfmt-rfc-style
    nixfmt-tree
    nix-prefetch-git
    nix-search

    # media
    shared-mime-info
    exiftool
  ];
}
