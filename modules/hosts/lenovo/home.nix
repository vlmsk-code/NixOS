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
    self.homeManagerModules.foot
    self.homeManagerModules.hyprland
  ];

  home.sessionVariables.EDITOR = "codium --wait";
  services.hyprpolkitagent.enable = true;

  home.packages = with pkgs; [
    ntfs3g
    obsidian
    android-tools
    payload-dumper-go
    freecad
    neovim
    vscodium
    firefox
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
