{ ... }: {
    boot.initrd.availableKernelModules = [
        "virtio_pci" "virtio_scsi" "virtio_blk"
        "ahci" "xhci_pci" "sr_mod"
    ];
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