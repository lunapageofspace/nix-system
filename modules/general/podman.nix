{ pkgs, ... }: {
    virtualisation.oci-containers.backend = "podman";
    virtualisation.podman = {
        enable = true;
        dockerCompat = true;
        dockerSocket.enable = true;
        defaultNetwork.settings.dns_enabled = true;
    };
    environment.systemPackages = with pkgs; [
        docker-compose
        podman-compose
        podman-tui
        distrobox
        dive
    ];
}