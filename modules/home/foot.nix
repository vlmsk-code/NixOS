{ ... }: {
  flake.homeManagerModules.foot = { ... }: {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          font = "JetBrainsMono Nerd Font Mono:size=12";
          include = "~/.config/foot/themes/noctalia";
        };
        cursor = {
          style = "beam";
        };
      };
    };
  };
}
