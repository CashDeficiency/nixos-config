{ config, pkgs, ... }:

{
  home.username = "cashd";
  home.homeDirectory = "/home/cashd";

  home.packages = with pkgs; [
    firefox
    google-chrome
    openvpn
  ];

  programs.git = {
    enable = true;
    userName = "CashDeficiency";
    userEmail = "cashdeficiency@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # Symlink config files
  home.file = {
    "${config.xdg.configHome}/i3" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/i3";
    };
    "${config.xdg.configHome}/polybar" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/polybar";
    };
    "${config.xdg.configHome}/alacritty" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/alacritty";
    };
  };

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
