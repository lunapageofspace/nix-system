{
    inputs,
    system,
    name,
    users       ? [ ../modules/users/nixos.nix ],
    primaryUser ? "nixos",
    version     ? "26.05",
    desktop     ? null,          # null | "gnome" | "plasma" | "hyprland"
    hardware    ? { },
    extra       ? { },
    extraModules ? [ ],
    lib ? inputs.nixpkgs.lib,
    ...
}@args:
let
    pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [(import ../overlays/pkgs)];
        config.allowUnfree = true;
    };
    pkgs-unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
    };
    specialArgs = {
        inherit inputs version pkgs pkgs-unstable hardware extra desktop primaryUser;
        hostname = name;
    };
in lib.nixosSystem {
    inherit system specialArgs;
    modules = [
        ../hosts/${name}
        ../modules/desktop
        ../modules/extraTools
        #../modules/gaming
        ../modules/general
        ../modules/hardware
        #../modules/ml
        inputs.home-manager.nixosModules.home-manager
        { 
            system.stateVersion = version;
            nixpkgs.pkgs = pkgs;
            home-manager = {
                useGlobalPkgs   = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs hardware extra desktop version pkgs-unstable; };
            };
        }
    ]
    ++ extraModules
    ++ users;
}
