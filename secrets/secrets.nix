let
  # admins
  ceirs = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDTfSJByS/+4vIn4AMZMjy2ehWfHFDnSq2WXzMDZnXDk ceirs@lvl";
  ludw = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGHBIf2ycXKqaa5o8isf99gRFRhtvefyjq1ib/x0lF9e ludw@lvl";
  redi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGe437tVoIrqmV1UzVBObyvsr+pNJ6Gp+UgQtWx6frpV redi@lvl";

  system_host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOe6C64fZmVmZN1uQSJexFBoQRFaQXOpfg9piE+r8cdQ";

  all_keys = [
    ludw
    ceirs
    redi

    system_host
  ];
in
{
  "copyparty-pw.age".publicKeys = all_keys;
  "syncthing-pw.age".publicKeys = all_keys;
}
