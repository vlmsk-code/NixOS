{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../modules/home-manager
  ];

  services.hyprpolkitagent.enable = true;

  home.packages = with pkgs; [
    alejandra
    nil
    helix
    cura-appimage
    onlyoffice-desktopeditors
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
    # inputs.noctalia.packages.${stdenv.hostPlatform.system}.default
    inputs.zen-browser.packages.${stdenv.hostPlatform.system}.default
  ];

  home.username = "vlmsk";
  home.homeDirectory = "/home/vlmsk";
  home.stateVersion = "26.05";
  home.sessionVariables = {
    EDITOR = "hx";
  };

  programs.home-manager.enable = true;
}
