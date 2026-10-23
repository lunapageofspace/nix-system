{ ... }: {
    imports = [
        ./filesystems.nix
        ./network.nix
        ./swap.nix
        ./syncthing.nix
    ];
}