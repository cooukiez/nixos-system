/*
  secrets/secrets.nix

  created by ludw
  on 2026-02-23
*/

let
  ludw = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHFFrZLZVIUZBYTGX5gRONHPEv+5QAhq8i6Rm9wHeasK";
  redi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGe437tVoIrqmV1UzVBObyvsr+pNJ6Gp+UgQtWx6frpV";

  ceirs = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDTfSJByS/+4vIn4AMZMjy2ehWfHFDnSq2WXzMDZnXDk";

  lvl = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOe6C64fZmVmZN1uQSJexFBoQRFaQXOpfg9piE+r8cdQ";

  allKeys = [
    ludw
    ceirs
    redi

    lvl
  ];
in
{
  "mail/ludwig-mailbox.age".publicKeys = allKeys;
  "mail/ludwig-web.age".publicKeys = allKeys;
  "mail/web.age".publicKeys = allKeys;

  "smb/fritz.age".publicKeys = allKeys;

  "ssh/ludw.age".publicKeys = allKeys;
  "ssh/redi.age".publicKeys = allKeys;

  "ssh/ceirs.age".publicKeys = allKeys;

  "tailscale-key.age".publicKeys = allKeys;

  "github-token.age".publicKeys = allKeys;
  "github-token-classic.age".publicKeys = allKeys;
}
