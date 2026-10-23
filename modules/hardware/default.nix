{ hardware ? { }, lib, ... }:
{
    imports =
        [ ]
        ++ lib.optional ((hardware.amdgpu     or false) == true) ./amdgpu.nix
        ++ lib.optional ((hardware.hypervisor or false) == true) ./hypervisor.nix
        ++ lib.optional ((hardware.liveiso    or false) == true) ./liveiso.nix
        ++ lib.optional ((hardware.vmguest    or false) == true) ./vmguest.nix
    ;
}