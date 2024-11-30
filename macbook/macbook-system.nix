{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "wl" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 8*1024;
  }];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  nixpkgs.config.allowUnfree = true;
  hardware.facetimehd.enable = true;

  # swap left ctrl and fn, and 
  # make function keys the default action without pressing fn
  boot.extraModprobeConfig = ''
    options hid_apple swap_fn_leftctrl=1
    options hid_apple fnmode=2
  '';

  # reverse scrolling direction
  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  # fix "too many open files" error
  systemd.extraConfig = "DefaultLimitNOFILE=2048";
}
