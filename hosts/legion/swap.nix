_: {
    boot.zswap = {
        enable = true;
    };
    swapDevices = [
        {
            device = "/var/lib/swapfile";
            size = 16*1024; # 16 GiB
        }
        {
            device = "/var/drives/Samsung_SSD_870_EVO_1TB_S625NJ0R276483W/swapfile";
            size = 32*1024; # 32 GiB
        }
    ];
}