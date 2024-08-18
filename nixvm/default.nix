{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
  };

  networking.hostName = "nixvm";
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver = {
    enable = true;
    desktopManager.cinnamon.enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.spice-vdagentd.enable = true;

  users.users.nixos = {
    isNormalUser = true;
    description = "nixos";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      google-chrome
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    neovim
    spice-vdagent
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.autoUpgrade = {
    enable = true;
    operation = "boot";
  };

  system.stateVersion = "24.05";
}
