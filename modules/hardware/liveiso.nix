{ inputs, lib, hostname, ...}: {
    imports = [ "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix" ];
    image.baseName = lib.mkForce hostname;
    services.openssh.settings.PermitRootLogin = lib.mkForce "yes";
}