{ pkgs, ... }: {
    environment.variables.EDITOR = "nvim";
    environment.variables.VISUAL = "nvim";
    environment.systemPackages = with pkgs; [
        #(uutils-coreutils.override { prefix = ""; })
        pinentry-curses
        nix-prefetch
        neovim
        p7zip
        unrar
        strace
        ltrace
        bpftrace
        tcpdump
        lsof
        sysstat
        iotop
        iftop
        btop
        nmon
        sysbench
        psmisc
        lm_sensors
        ethtool
        pciutils
        usbutils
        hdparm
        dmidecode
        parted
        doggo
        dig
        mtr
        jq
        restic
        rsync
        s3fs
        sshfs
        openssl
        zellij
        minicom
        python3
    ];
}