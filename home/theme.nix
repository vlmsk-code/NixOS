{ pkgs, ... }: {

  gtk = {
    enable = true;
    colorScheme = "dark";
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
    cursorTheme = {
      package = pkgs.quintom-cursor-theme;
      name = "Quintom_Ink";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };
  home.sessionVariables = {
    XCURSOR_THEME = "Quintom_Ink";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_THEME = "Quintom_Ink";
    HYPRCURSOR_SIZE = "24";
  };
}
