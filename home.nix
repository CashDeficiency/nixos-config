{ config, pkgs, ... }:

{
  home.username = "cashd";
  home.homeDirectory = "/home/cashd";

  home.packages = with pkgs; [
    firefox
    google-chrome
  ];

  programs.git = {
    enable = true;
    userName = "CashDeficiency";
    userEmail = "cashdeficiency@gmail.com";
  };

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
