{ pkgs, ... }: {
    fonts.packages = with pkgs; [
        # Nerd-Fonts
        nerd-fonts.ubuntu
        nerd-fonts.ubuntu-mono
        nerd-fonts.caskaydia-cove
        nerd-fonts.caskaydia-mono
        nerd-fonts.open-dyslexic
        nerd-fonts.noto
        # Other
        openmoji-color
        noto-fonts
    ];
    fonts.fontDir.enable = true;
    fonts.fontconfig = {
        enable = true;
        hinting.autohint = true;
        defaultFonts = {
            monospace = ["CaskaydiaCove Nerd Font Mono" "OpenDyslexicM Nerd Font Mono"];
            emoji = [ "OpenMoji Color,OpenMoji" ];
        };
    };
}