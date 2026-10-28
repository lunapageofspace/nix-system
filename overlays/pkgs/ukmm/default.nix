self: super: {
    ukmm-bin = super.stdenv.mkDerivation rec {
        pname = "ukmm";
        version = "0.17.1";

        src = super.fetchurl {
            url = "https://github.com/NiceneNerd/UKMM/releases/download/v${version}/ukmm-x86_64-unknown-linux-gnu.tar.xz";
            # Run `nix-prefetch-url <url>` to get the correct sha256 hash
            sha256 = "1xrm4hmrjq5hrv62b95wm5z7b2dg48kvv01l4r9rp1lxh22fgi4l";
        };

        nativeBuildInputs = with super; [
            autoPatchelfHook
        ];

        buildInputs = with super; [
            libGL
            libxkbcommon
            openssl
            wayland
            libx11
            libxcursor
            libxrandr
            libxi
        ];

        # The tarball contains a single `ukmm` executable at its root.
        dontConfigure = true;
        dontBuild = true;

        installPhase = ''
            runHook preInstall
            mkdir -p $out/bin
            cp ukmm $out/bin/
            runHook postInstall
        '';

        meta = with super.lib; {
            description = "New mod manager for The Legend of Zelda: Breath of the Wild (pre-built binary)";
            homepage = "https://github.com/NiceneNerd/UKMM";
            license = licenses.gpl3Plus;
            platforms = [ "x86_64-linux" ];
            mainProgram = "ukmm";
        };
    };
}