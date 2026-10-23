{ pkgs, lib, ... }: {
    boot.binfmt.registrations.appimage = {
        wrapInterpreterInShell = false;
        interpreter = "${pkgs.appimage-run}/bin/appimage-run";
        recognitionType = "magic";
        offset = 0;
        mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
        magicOrExtension = ''\x7fELF....AI\x02'';
    };
    boot.loader.systemd-boot = {
        enable = true;
        configurationLimit = lib.mkDefault 10;
        consoleMode = lib.mkDefault "max";
    };
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernel.sysctl = { "kernel.sysrq" = 0; }; # Disable SysRq keychord
    boot.tmp.useTmpfs = true; # Use RAM for /tmp/
    systemd.oomd = {
        enableRootSlice = true;
        enableUserSlices = true;
    };
    services = {
        power-profiles-daemon.enable = true;
        upower.enable = true;
    };
    documentation = {
        enable = true;
        doc.enable = false;
        man.enable = true;
        dev.enable = false;
    };
}