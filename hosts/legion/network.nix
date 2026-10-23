{ config, pkgs, lib, ... }: {
    config = lib.mkMerge ([
        { services.ivpn.enable = true; }
        { # System Network Interfaces
            boot.kernelModules = [ "bridge" "stp" ];
            networking.bridges."bridge0" = {
                interfaces = [ "enp7s0" "enp11s0" ];
                rstp = true;
            };
            networking.vlans = {
                "bridge0.10" = { id = 10; interface = "bridge0"; };
            };
            networking.interfaces = {
                "bridge0" = { # Shared bridge for VLANs
                    useDHCP = true;
                };
                "bridge0.10" = { # Management VLAN
                    useDHCP = false;
                    ipv4.addresses = [{
                        address = "172.22.0.2";
                        prefixLength = 24;
                    }];
                };
            };
        }
        { # System Firewall
            networking.firewall = {
                allowedTCPPorts = [ 22 80 443 42420 ];
                allowedUDPPorts = [ 42420 ];
                allowedUDPPortRanges = [
                    { from = 40000; to = 50000; }
                ];
            };
        }
    ]);
}