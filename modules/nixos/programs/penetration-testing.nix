{
  pkgs,
  ...
}:
{
  # https://github.com/NixOS/nixpkgs/issues/81418
  environment.systemPackages = with pkgs; [
    ### exploitation ###
    commix
    crackle
    exploitdb
    linux-exploit-suggester
    metasploit
    msfpc
    routersploit
    sqlmap
    thc-ipv6
    yersinia

    ### forensics ###
    #binwalk-full
    #bulk-extractor
    capstone
    dc3dd
    ddrescue
    ddrescueview
    #distorm3
    ext4magic
    extundelete
    galleta
    #ghidra
    p0f
    pdf-parser
    regripper
    sleuthkit
    #volatility

    ### hardware ###
    apktool
    arduino
    #bytecode-viewer
    dex2jar
    enjarify

    ### information gathering ###
    arp-scan
    braa
    dnsenum
    dnsrecon
    enum4linux
    gowitness
    faraday-cli
    fierce
    firewalk
    hping
    masscan
    nmap
    ntopng
    smbmap
    sn0int
    sslsplit
    sslstrip
    #sslyze
    theharvester
    testssl
    wireshark

    ### maintaining access ###
    httptunnel
    pwnat

    ### passwords ###
    brutespray
    cewl
    chntpw
    cmospwd
    #creddump
    crowbar
    crunch
    hash-identifier
    hashcat
    hashcat-utils
    hcxtools
    thc-hydra
    john
    johnny
    ncrack
    #patator
    phrasendrescher
    seclists
    truecrack

    ### reporting ###
    cherrytree

    ### sniffing and spoofing ###
    bettercap
    dnschef
    dsniff
    mitmproxy
    responder
    rshijack
    sipp
    sipvicious
    sniffglue

    ### stress testing ###
    dhcpig
    reaverwps
    reaverwps-t6x
    slowhttptest

    ### vulnerability analysis ###
    doona
    lynis
    vulnix

    ### web applications ###
    apache-users
    #burpsuite
    davtest
    dirb
    gobuster
    hurl
    joomscan
    nikto
    padbuster
    parsero
    plecost
    websploit
    wfuzz
    whatweb
    wpscan
    #xsser
    zap

    ### wireless ###
    aircrack-ng
    asleap
    bully
    cowpatty
    gqrx
    kalibrate-hackrf
    kalibrate-rtl
    killerbee
    kismet
    mfcuk
    mfoc
    multimon-ng
    pixiewps
    #pyrit
    redfang
    wifite2
  ];
}
