{ self, inputs, ... }: {
  flake.nixosConfigurations.lenovo = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.lenovoConfiguration
    ];
  };

  flake.nixosModules.lenovoConfiguration =
    {
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.disko.nixosModules.disko
        inputs.home-manager.nixosModules.home-manager
        ./disko.nix
        ./hardware-configuration.nix

        self.nixosModules.user
        self.nixosModules.limine

        self.nixosModules.thunar
        self.nixosModules.desktop
      ];

      boot.kernelPackages = pkgs.linuxPackages_latest;

      # Hostname
      networking.hostName = "lenovo";

      # Hardware
      networking.networkmanager.enable = true;
      hardware.bluetooth.enable = true;
      services.power-profiles-daemon.enable = true;
      services.upower.enable = true;

      # Security
      security = {
        sudo.wheelNeedsPassword = false;
        polkit = {
          enable = true;
          extraConfig = ''
            polkit.addRule(function(action, subject) {
              if (subject.isInGroup("wheel")) {
                return polkit.Result.YES;
              }
            });
          '';
        };
      };

      # Allow unfree firmware (WiFi, etc.)
      nixpkgs.config.allowUnfree = true;
      hardware.enableRedistributableFirmware = true;

      # Flakes support
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      # Minimal packages
      environment.systemPackages = with pkgs; [
        nixfmt
        nixd
        git
        wget
        curl
        fastfetch
      ];

      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];

      # VPN
      programs.clash-verge = {
        enable = true;
        serviceMode = true;
        tunMode = true;
      };

      # State version
      system.stateVersion = "26.05";

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs self; };
        backupFileExtension = "backup";
        overwriteBackup = true;
        users.vlmsk = import ./home.nix;
      };
    };
}
