{ config, ... }: rec {
    services.syncthing = {
        enable = false;
        user = "elliana";
        dataDir = "/home/elliana/";
        configDir = "/home/elliana/.config/syncthing";
        #extraFlags = [ "--reset-deltas" ];
        overrideDevices = true;
        overrideFolders = true;
        settings = {
            devices = {
                "Kubernetes" = { 
                    introducer = true;
                    addresses = [
                        "quic://172.21.0.2:22000"
                        "dynamic"
                    ];
                };
                "Pixel 6" = {
                    introducer = false;
                    addresses = ["dynamic"];
                };
            };
            folders = {
                "Documents" = {
                    path = "/home/elliana/Documents";
                    devices = [ "Kubernetes" "Pixel 6" ];
                };
                "Code" = {
                    path = "/home/elliana/Code";
                    devices = [ "Kubernetes" "Pixel 6" ];
                };
                "Sync" = {
                    path = "/home/elliana/Sync";
                    devices = [ "Kubernetes" "Pixel 6" ];
                };
            };
        };
    };
}
