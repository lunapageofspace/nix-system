{
    description = "Nixos system configurations";

    inputs = {
        nixpkgs.url         = "github:NixOS/nixpkgs/nixos-26.05";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        home-config = {
            #url = "git+file:///home/elliana/Code/nix-home";
            url = "github:lunapageofspace/nix-home";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ self, nixpkgs, ... }:
    let
        version     = "26.05";
        nixosSystem = import ./lib/nixosSystem.nix;
        mkHost = name: cfg: nixosSystem ({
            inherit inputs nixpkgs version name;
            system = "x86_64-linux";
        } // cfg);
    in {
        nixosConfigurations = {
            dixie = mkHost "dixie" {
                primaryUser = "elliana";
                users = [ modules/users/elliana.nix ];
                extraModules = [ modules/gaming ];
                hardware = { vmguest = true; hypervisor = true; };
                extra    = { yubikey = true; fullDesktop = true; };
                desktop  = "plasma";
            };
            legion = mkHost "legion" {
                primaryUser = "elliana";
                users = [ modules/users/elliana.nix ];
                extraModules = [ modules/gaming ];
                hardware = { vmguest = true; hypervisor = true; };
                extra    = { yubikey = true; fullDesktop = true; };
                desktop  = "plasma";
            };
            mnemosyne = mkHost "mnemosyne" {
                primaryUser = "nixos";
                hardware = { liveiso = true; vmguest = true; };
                extra    = { yubikey = true; };
                desktop  = "hyprland";
            };
        };
        checks."x86_64-linux" = {
            legion     = self.nixosConfigurations.legion.config.system.build.toplevel;
            mnemosyne   = self.nixosConfigurations.ephemera.config.system.build.isoImage;
        };
        formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };
}
