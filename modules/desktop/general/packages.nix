{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        celluloid
    ];
}
