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
    ngrok
    speedtest-cli
  ];

  tui = with pkgs; [
    bandwhich
    gping
  ];
}
