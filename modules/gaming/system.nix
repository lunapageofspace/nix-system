{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        ivpn
        icu
        zulu17 # Java Runtime 17 ( Starsector )
        gamemode
        gamescope
        protonup-qt
        steamtinkerlaunch
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