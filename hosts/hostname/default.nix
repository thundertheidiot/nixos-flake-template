{
  # NixOS module
  system = {...}: {
    system.stateVersion = "24.11";
    time.timeZone = "Europe/Helsinki";
    networking.hostName = "hostname";

    # Hardware configuration
    # nixos-generate-config
    nixpkgs.hostPlatform = {system = "x86_64-linux";};

    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      devices = ["nodev"];
    };

    # Check disko.nix
    boot.loader.efi.efiSysMountPoint = "/boot";

    # Read modules/nixos/gaming.nix
    mynixos.gaming.enable = true;

    imports = [
      ./disko.nix
    ];
  };

  # Home Manager module
  home = {...}: {
    home.stateVersion = "24.11";
  };
}
