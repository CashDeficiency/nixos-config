{ config, pkgs, ... }:

{
  home.username = "cashd";
  home.homeDirectory = "/home/cashd";

  home.packages = with pkgs; [
    firefox
    google-chrome
    obs-studio
    openvpn
    vlc
  ];

  programs.git = {
    enable = true;
    userName = "CashDeficiency";
    userEmail = "cashdeficiency@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
    ignores = [
      ".direnv"
      ".envrc"
      "shell.nix"
    ];
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''export PS1="\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\$\[\033[0m\] "'';
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  # Symlink config files
  home.file = {
    "${config.xdg.configHome}/i3" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/i3";
    };
    "${config.xdg.configHome}/polybar" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/polybar";
    };
    "${config.xdg.configHome}/rofi" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/rofi";
    };
    "${config.xdg.configHome}/alacritty" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/alacritty";
    };
  };

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
