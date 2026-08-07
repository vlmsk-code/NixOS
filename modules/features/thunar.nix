{ ... }: {
  flake.nixosModules.thunar = { pkgs, ... }: {
    programs.thunar.enable = true;
    programs.thunar.plugins = with pkgs; [
      gvfs
      thunar-archive-plugin
      thunar-volman
    ];
    services.gvfs.enable = true;
    services.tumbler.enable = true;
  };
}
