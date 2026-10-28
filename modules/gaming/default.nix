{ pkgs, ... }: {
    # ntsync: low-latency Wine/Proton synchronization
    boot.kernelModules = ["ntsync"];

    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
        localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
        gamescopeSession.enable = false;
    };

    programs.gamescope = {
        enable = true;
        capSysNice = true;
    };

    environment.systemPackages = with pkgs; [
        winetricks
        protonup-qt
        steamtinkerlaunch
        wineWow64Packages.stable
        wineWow64Packages.waylandFull
        (lutris.override {
            extraLibraries =  pkgs: [
                # List library dependencies here
            ];
            extraPkgs = pkgs: [
                # List package dependencies here
            ];
        })
        # overrides the NixOS package, starsector, see: https://wiki.nixos.org/wiki/Starsector
        (pkgs.starsector.overrideAttrs ({ ... }: {
            #postInstall = ''
            #  cp ${dotfiles/starsector/settings.json} $out/share/starsector/data/config/settings.json
            #  substituteInPlace $out/share/starsector/.starsector.sh-wrapped \
            #    --replace-fail "Xms1536m" "Xms8192m" \
            #    --replace-fail "Xmx1536m" "Xmx8192m"
            #'';
        }))
    ];
}