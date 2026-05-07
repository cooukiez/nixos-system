/*
  secrets/secrets.nix

  created by ludw
  on 2026-02-23
*/

let
  ludw = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHFFrZLZVIUZBYTGX5gRONHPEv+5QAhq8i6Rm9wHeasK ludw@lvl";

  ceirs = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDTfSJByS/+4vIn4AMZMjy2ehWfHFDnSq2WXzMDZnXDk ceirs@lvl";
  redi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGe437tVoIrqmV1UzVBObyvsr+pNJ6Gp+UgQtWx6frpV redi@lvl";

  lvl = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOe6C64fZmVmZN1uQSJexFBoQRFaQXOpfg9piE+r8cdQ";

  allKeys = [
    ludw
    ceirs
    redi

    lvl
  ];
in
{
  "tailscale-key.age".publicKeys = allKeys;
  "fritz-creds.age".publicKeys = allKeys;
  "github-token.age".publicKeys = allKeys;
}
