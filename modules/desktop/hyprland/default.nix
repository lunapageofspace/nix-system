{ inputs, pkgs, pkgs-unstable, primaryUser, ... }: {
    programs.hyprland = {
        enable = true;
        package = pkgs-unstable.hyprland;
    };

    # Enable Display Manager
    services.greetd = {
        enable = true;
        settings = rec {
            default_session = autologin;
            login_required = {
                command = "${pkgs.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
                user = "greeter";
            };
            autologin = {
                command = "${pkgs.hyprland}/bin/Hyprland";
                user = primaryUser;
            };
        };
    };
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    environment.systemPackages = with pkgs; [
        tuigreet
        # --Utils and more--
        wlr-randr
        brightnessctl
        swaynotificationcenter
        hyprpicker
        pamixer
        networkmanagerapplet
        playerctl

        # --Background--
        pkgs-unstable.awww

        # --Screenshots--
        grim
        slurp

        # --Overlays Bars and more--
        pkgs-unstable.waybar
        wlogout
        nwg-drawer

        nemo
        wl-clipboard
        kitty
    ];
}