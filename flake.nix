{
    description = "Nixos system configurations";

    inputs = {
        nixpkgs.url         = "github:NixOS/nixpkgs/nixos-26.05";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
        nixos-hardware.url  = "github:nixos/nixos-hardware";
        impermanence = {
            url = "github:nix-community/impermanence";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nix-flatpak = {
            url = "github:gmodena/nix-flatpak/?ref=v0.4.1";
        };
        eden = {
            url = "github:daaboulex/eden-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        home-config = {
            url = "git+file:///home/elliana/Code/nix-home";
            #url = "github:lunapageofspace/nix-home";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        agenix = {
            url = "github:ryantm/agenix";
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
                users = [ modules/users/elliana.nix ];
                primaryUser = "elliana";
                hardware = { vmguest = true; };
                extra    = { yubikey = true; };
                desktop  = "hyprland";
            };
            legion = mkHost "legion" {
                users = [ modules/users/elliana.nix ];
                primaryUser = "elliana";
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