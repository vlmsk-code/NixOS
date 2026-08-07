{ ... }: {
  flake.nixosModules.limine = { ... }: {
    boot = {
      loader = {
        efi.canTouchEfiVariables = true;
        limine = {
          enable = true;
          efiSupport = true;
          style.wallpapers = [ ];
          style.graphicalTerminal.background = "00000000";
          extraEntries = ''
                  /Windows
                    protocol: efi
            	path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
          '';
        };
      };
    };
  };
}
