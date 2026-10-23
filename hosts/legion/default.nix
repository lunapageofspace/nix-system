{ config, lib, inputs, pkgs, ... }: {
    # Include AMD Microcode
    programs.nix-ld.enable = true;
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    hardware.enableRedistributableFirmware = true;
    boot.extraModulePackages = [ ];
    boot.initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
    ];
    boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
    };
    imports = [
        ./filesystems.nix
        ./network.nix
        ./swap.nix
        ./syncthing.nix
    ];
}