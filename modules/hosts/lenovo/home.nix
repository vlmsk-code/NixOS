{
  self,
  pkgs,
  inputs,
  ...
}:
{

  imports = [
    self.homeManagerModules.fish
    self.homeManagerModules.git
    self.homeManagerModules.nh
    self.homeManagerModules.theme
  ];

  home.packages = with pkgs; [
    obsidian
    android-tools
    payload-dumper-go
    freecad
    gcc
    hyprpolkitagent
    neovim
    vscodium
    firefox
    foot
    gvfs
    telegram-desktop
    evtest
    file-roller
    qbittorrent
    inputs.noctalia.packages.${stdenv.hostPlatform.system}.default
    inputs.zen-browser.packages.${stdenv.hostPlatform.system}.default
  ];

  home.username = "vlmsk";
  home.homeDirectory = "/home/vlmsk";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
