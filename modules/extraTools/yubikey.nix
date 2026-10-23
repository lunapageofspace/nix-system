{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        cfssl
        openssl
        cryptsetup
        diceware
        ent
        git
        git-extras
        gnupg
        paperkey
        parted
        pcsclite
        pcsc-tools
        pgpdump
        pinentry-curses
        pwgen
        yubikey-manager
        yubikey-personalization
        # Yubikey - Openssl engine
        openssl
        opensc
        libp11
        p11-kit
    ];
    services.pcscd.enable = true;
    services.udev.packages = [
        pkgs.yubikey-personalization
    ];
    environment.etc."pkcs11/modules/opensc".text = ''
        module: ${pkgs.opensc}/lib/opensc-pkcs11.so
    '';
    environment.etc."ssl/openssl.cnf".text = ''
        openssl_conf = openssl_init
        [openssl_init]
        engines=engine_section
        [engine_section]
        pkcs11 = pkcs11_section
        [pkcs11_section]
        engine_id = pkcs11
        dynamic_path = ${pkgs.libp11}/lib/engines/libpkcs11.so
        MODULE_PATH = ${pkgs.opensc}/lib/pkcs11/opensc-pkcs11.so
        init = 0
    '';
}