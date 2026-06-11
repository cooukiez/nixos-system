/*
secrets/secrets.nix

part of nixos system
created 2026-02-23 by ludw
*/
let
  ludw = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHFFrZLZVIUZBYTGX5gRONHPEv+5QAhq8i6Rm9wHeasK";
  redi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGe437tVoIrqmV1UzVBObyvsr+pNJ6Gp+UgQtWx6frpV";

  ceirs = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDTfSJByS/+4vIn4AMZMjy2ehWfHFDnSq2WXzMDZnXDk";

  lvl = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOe6C64fZmVmZN1uQSJexFBoQRFaQXOpfg9piE+r8cdQ";
  rtp = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJg+fbJcNykFYfpwCNE1xDVXvs6cBwYm67mKQz687c1j";

  allKeys = [
    ludw
    ceirs
    redi

    lvl
    rtp
  ];
in {
  "dav/ludwig-radicale.age".publicKeys = allKeys;

  "mail/ludwig-mailbox.age".publicKeys = allKeys;
  "mail/ludwig-web.age".publicKeys = allKeys;
  "mail/web.age".publicKeys = allKeys;

  "passwords/ceirs.age".publicKeys = allKeys;
  "passwords/ludw.age".publicKeys = allKeys;
  "passwords/redi.age".publicKeys = allKeys;

  "smb/dhs.age".publicKeys = allKeys;
  "smb/fritz.age".publicKeys = allKeys;

  "ssh/ludw.age".publicKeys = allKeys;
  "ssh/redi.age".publicKeys = allKeys;

  "ssh/ceirs.age".publicKeys = allKeys;

  "copyparty.age".publicKeys = allKeys;

  "gpg-public.age".publicKeys = allKeys;
  "gpg-secret.age".publicKeys = allKeys;

  "github-token.age".publicKeys = allKeys;
  "github-token-classic.age".publicKeys = allKeys;

  "tailscale-key.age".publicKeys = allKeys;
}
