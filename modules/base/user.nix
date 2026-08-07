{ ... }: {
  flake.nixosModules.user = { pkgs, ... }: {
    time.timeZone = "Europe/Moscow";
    i18n.defaultLocale = "en_US.UTF-8";
    console.keyMap = "us";
    users.users.vlmsk = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "lenovoctl"
      ];
      shell = pkgs.fish;
    };
    programs.fish.enable = true;
  };
}
