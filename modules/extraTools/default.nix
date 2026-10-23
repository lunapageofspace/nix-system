{ extra ? { }, lib, ... }:
{
    imports =
        [ ]
        ++ lib.optional ((extra.vpn       or false) == true) ./vpn.nix
        ++ lib.optional ((extra.winbox    or false) == true) ./winbox.nix
        ++ lib.optional ((extra.yubikey   or false) == true) ./yubikey.nix
        ++ lib.optional ((extra.zsautil   or false) == true) ./zsautil.nix
    ;
}