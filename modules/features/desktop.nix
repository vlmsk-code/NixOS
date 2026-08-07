{ ... }: {
  flake.nixosModules.desktop = { ... }: {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    services.displayManager = {
      sddm.enable = true;
      sddm.wayland.enable = true;
      autoLogin.user = "vlmsk";
      autoLogin.enable = true;
    };
  };
}
