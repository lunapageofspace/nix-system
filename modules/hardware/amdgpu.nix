{ pkgs, pkgs-unstable, ... }:
{
    boot.kernelModules = [ "kvm-amd" ];
    boot.initrd.kernelModules = [ "amdgpu" ];
    services.xserver.videoDrivers = [ "amdgpu" ];
    hardware.enableRedistributableFirmware = true;
    hardware.graphics = {
        enable = true;
    };
    environment.systemPackages = with pkgs; [
        clinfo mesa-demos
    ];
}