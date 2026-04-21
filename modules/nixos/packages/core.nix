{
  inputs,
  hostSystem,
  ...
}:
{
  core =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
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
    };

  dev =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        clang
        cmake
        gcc
        gdb
        gnumake
        rustup

        shader-slang
        shaderc

        # python
        (python3.withPackages (
          ps: with ps; [
            numpy
            pandas
            emoji
          ]
        ))
      ];

      environment.shellAliases = {
        # dotnet version aliases
        dotnet8 = "${pkgs.dotnetCorePackages.sdk_8_0-bin}/bin/dotnet";
        dotnet9 = "${pkgs.dotnetCorePackages.sdk_9_0-bin}/bin/dotnet";
        dotnet10 = "${pkgs.dotnetCorePackages.sdk_10_0-bin}/bin/dotnet";
      };
    };

  filesystem =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        cifs-utils
        exfatprogs
        mtools
        ntfsprogs
        parted
        unixtools.quota

        ifuse
        cdrkit
        cdrtools
        fuse
        fuse3
        libburn
        libimobiledevice
        libimobiledevice-glue
      ];
    };

  utils =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        diffutils
        fdupes
        fzf
        toybox
      ];
    };

  hardware =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        bluez-tools
        cpuid
        mesa
        dmidecode
        intel-gpu-tools
        nvtopPackages.intel

        v4l-utils
        vulkan-tools
      ];
    };

  networking =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        inetutils
      ];
    };

  secrets =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.age
        pkgs.openssl

        inputs.agenix.packages.${hostSystem}.default
      ];
    };

  nix-utils =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        nixfmt-rfc-style
        nixfmt-tree
        nix-prefetch-git
        nix-search
      ];
    };

  media =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        imagemagick
        ffmpeg
        shared-mime-info
        exiftool
        libpng
        poppler-utils
        tesseract
        yt-dlp
      ];
    };
}
