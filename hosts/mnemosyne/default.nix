{lib, ...}: {
    boot.kernelParams = [ "copytoram" ];
    boot.initrd.network.enable = false;
    networking.dhcpcd.enable = false;
    networking.dhcpcd.allowInterfaces = [];
    networking.firewall.enable = true;
    networking.useDHCP = false;
    networking.useNetworkd = false;
    networking.wireless.enable = lib.mkForce false;
    boot.tmp.cleanOnBoot = true;
    boot.kernel.sysctl = {
        "kernel.unprivileged_bpf_disabled" = 1;
    };
}