{
  pkgs,
  ...
}:
{
  core = with pkgs; [
    apacheHttpd
    aria2
    dig
    httpie
    inetutils
    mtr
    ngrok
    speedtest-cli
  ];

  tui = with pkgs; [
    bandwhich
    gping
  ];
}
