{ pkgs, inputs, ... }: {

  imports = [
    ./disko.nix
  ];

  # Bootloader
  boot.loader.limine = {
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

  boot.loader.efi.canTouchEfiVariables = true;

  # Latest kernel for new hardware
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Hostname
  networking.hostName = "lenovo";

  # Hardware
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  # Locale
  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  # User
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

  # For noctalia conservation mode plugin
  users.groups.lenovoctl = { };
  services.udev.extraRules = ''
    ACTION=="add|change", SUBSYSTEM=="platform", DRIVER=="ideapad_acpi", RUN+="${pkgs.coreutils}/bin/chgrp lenovoctl /sys%p/conservation_mode", RUN+="${pkgs.coreutils}/bin/chmod 664 /sys%p/conservation_mode"
  '';

  # Sudo without password for wheel (optional, remove after setup)
  security.sudo.wheelNeedsPassword = false;

  # Minimal packages
  environment.systemPackages = with pkgs; [
    nixfmt
    nixd
    android-tools
    payload-dumper-go
    freecad
    git
    gcc
    hyprpolkitagent
    neovim
    vscodium
    wget
    curl
    firefox
    foot
    gvfs
    telegram-desktop
    evtest
    fastfetch
    file-roller
    qbittorrent
    inputs.noctalia.packages.${stdenv.hostPlatform.system}.default
    inputs.zen-browser.packages.${stdenv.hostPlatform.system}.default
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Hyprland
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

  # Thunar
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs; [
    gvfs
    thunar-archive-plugin
    thunar-volman
  ];
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  # VPN
  programs.clash-verge = {
    enable = true;
    serviceMode = true;
    tunMode = true;
  };

  # Polkit
  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (subject.isInGroup("wheel")) {
          return polkit.Result.YES;
        }
      });
    '';
  };

  # Allow unfree firmware (WiFi, etc.)
  nixpkgs.config.allowUnfree = true;
  hardware.enableRedistributableFirmware = true;

  # Flakes support
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # State version
  system.stateVersion = "26.05";
}
