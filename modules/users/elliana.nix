{ config, lib, pkgs, inputs, ... }:
let
    username = "elliana";
    fullname = "Elliana Perry";

    # Per-user auth. Replace with hashedPasswordFile = config.age.secrets.<name>.path
    # if you want agenix-managed passwords.
    passwordHash = "$y$j9T$zwImDNhx/m6xqpJk4y17s/$61DGJaZbKvtZaplx.d1Zj02fqwKUWoKPOB5fj1yd2y1";

    desiredGroups = [
        "users" "wheel" "audio" "video" "input" "plugdev" "dialout"
        "docker" "podman" "libvirtd" "wireshark" "networkmanager"
        "power" "nix" "lp" "systemd-journal" "adbusers"
    ];
    groupsIfExist = builtins.filter (g: builtins.hasAttr g config.users.groups) desiredGroups;
in
{
    users.groups.${username} = { };

    users.users.${username} = {
        isNormalUser    = true;
        description     = fullname;
        hashedPassword  = passwordHash;
        extraGroups     = groupsIfExist ++ [ username ];
        group           = username;
        shell           = pkgs.zsh;
        subGidRanges    = [{ count = 65535; startGid = 100000; }];
        subUidRanges    = [{ count = 65535; startUid = 100000; }];
    };

    home-manager.users.${username} = {
        imports = [
            inputs.home-config.homeModules.default
            inputs.home-config.homeModules.${username}
        ];
        home = {
            username     = username;
            homeDirectory = "/home/${username}";
            stateVersion = "26.05";
        };
    };
}