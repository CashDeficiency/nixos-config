{ config, pkgs, ...}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  # ---
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot = {
    enable = true;
    consoleMode = "max"; # max out boot screen size
    editor = false; # disable kernel edit before boot
    configurationLimit = 10;
  };

  # Networking
  # ---
  networking.hostName = "MacBookAir"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Time and Locale
  # ---
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # System Environment
  # ---
  services.xserver.enable = true;
  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      i3lock
      rofi
      polybar
    ];
  };
  environment.systemPackages = with pkgs; [
    git
    neovim
  ];
  environment.variables.EDITOR = "nvim";
  virtualisation.docker.enable = true;

  # Sound
  # ---
  hardware.pulseaudio.enable = true;

  # Fonts
  # ---
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      fira-code
      fira-code-symbols
      font-awesome
    ];

    fontconfig.defaultFonts.monospace = [ "Fira Code" ];
  };

  # User Environment
  # ---
  users.users.cashd = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker"];
    # more settings are managed by home-manager
  };

  # System Maintenance
  # ---
  # enable auto upgrade and auto garbage collection
  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
    operation = "boot";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Misc configs:
  # ---
  nixpkgs.config.allowUnfree = true;  # for unfree software like broadcom_sta
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # swap left ctrl and fn on MacBook Air
  boot.extraModprobeConfig = ''
  options hid_apple swap_fn_leftctrl=1
  '';

  # use natural scrolling on MacBook Air trackpad
  services.libinput.enable = true;
  services.libinput.touchpad.naturalScrolling = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}
