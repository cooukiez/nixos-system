{
  environment.systemPackages = with pkgs; [
    cifs-utils
    exfatprogs
    mtools
    ntfsprogs
    parted
    unixtools.quota
  ];
}
