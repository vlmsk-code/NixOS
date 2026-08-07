{ ... }: {
  flake.homeManagerModules.hyprland = { ... }: {
    home.file = {
      ".config/hypr/hyprland.lua".source = ./hyprland.lua;
    };
  };
}
