{ ... }: {
    swapDevices = [ ];
    fileSystems."/boot" = {
        device = "/dev/vda1";
        fsType = "vfat";
    };
    fileSystems."/" = {
        device = "/dev/vda2";
        fsType = "ext4";
        options = [ "noatime" ];
    };
}