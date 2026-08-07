{ ... }: {
  programs.nh = {
    enable = true;
    flake = "~/nixos-config";

    clean = {
      enable = true;
      extraArgs = "--keep-since 4d --keep 3";
    };
  };
}
